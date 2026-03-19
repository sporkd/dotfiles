function _prompt() {
  local usage="USAGE: prompt [-p <prompt_text>] [-d <default_value>] [-r <match_regex>] [-e <match_print_error>] [-c] result_var"
  local OPTIND prompt_text= default_value= match_regex= match_print_error="is not valid" continue_key=

  while getopts "h?cd:e:r:p:" opt; do
    case ${opt} in
      c) continue_key=true ;;
      d) default_value=${OPTARG} ;;
      e) match_print_error=${OPTARG} ;;
      r) match_regex=${OPTARG} ;;
      p) prompt_text=${OPTARG} ;;
      *) echo "$usage" >&2; return 1 ;;
    esac
  done
  shift $((OPTIND-1))

  local _result_var="$1"
  local _value=""

  # Flush the buffer
  while read -t 0 && read -k 1; do; done

  if [[ -n "$continue_key" ]]; then
    local msg="${prompt_text:-"continue"}"
    echo -e "${FG_CYAN}[...]${RESET} $msg (press any key to continue)"
    read -k 1 -s
    return 0
  fi

  while :; do
    vared -p "$(echo -e "${FG_CYAN}[?]${RESET} ${prompt_text}") " -c _value

    _value="${_value:-$default_value}"

    if [[ -z "$_value" ]]; then
      echo -e "${FG_RED}[!]${RESET} Error: Cannot be blank" >&2
      continue
    fi

    if [[ -n "$match_regex" ]]; then
      if [[ ! "$_value" =~ $match_regex ]]; then
        echo -e "${FG_RED}[!]${RESET} Error: [$_value] $match_print_error" >&2
        _value="" # Clear value for next attempt
        continue
      fi
    fi

    if [[ -n "$_result_var" ]]; then
      typeset -g "$_result_var=$_value"
    fi
    return 0
  done
}
