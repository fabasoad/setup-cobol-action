#!/usr/bin/env sh


# Validates string to be one of the possible values (emulating enum data type).
# Parameters:
# 1. (Required) Param name to display it correctly in the error message for the
#    users.
# 2. (Required) Param value that will be validated.
# 3. (Required) Possible values for the param value to be valid.
#
# Usage examples:
# check_enum "my-bool-param" "true" "true,false"
# check_enum "my-days-of-week-param" "wed" "mon,tue,wed,thu,fri,sat,sun"
check_enum() {
  case ",${3}," in
    *",${2},"*)
      ;;
    *)
      msg="\"${1}\" parameter is invalid. Possible values: $(echo "${3}" | sed 's/,/, /g')."
      echo "::error title=Invalid parameter::${msg}"
      exit 1
      ;;
  esac
}

main() {
  input_force="${1}"

  check_enum "force" "${input_force}" "true,false"
}

main "$@"
