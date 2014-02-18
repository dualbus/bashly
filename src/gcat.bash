#!/bin/bash

: load common
: load cmdline


function escape_line {
  typeset line=$1
  typeset i character escaped_line
  typeset -A replacements=(
  [$'\001']='^A' [$'\002']='^B' [$'\003']='^C'
  [$'\004']='^D' [$'\005']='^E' [$'\006']='^F' [$'\a']='^G'
  [$'\b']='^H' [$'\t']='^I' [$'\v']='^K' [$'\f']='^L'
  [$'\r']='^M' [$'\016']='^N' [$'\017']='^O' [$'\020']='^P'
  [$'\021']='^Q' [$'\022']='^R' [$'\023']='^S' [$'\024']='^T'
  [$'\025']='^U' [$'\026']='^V' [$'\027']='^W' [$'\030']='^X'
  [$'\031']='^Y' [$'\032']='^Z' [$'\E']='^[' [$'\034']='^\'
  [$'\035']='^]' [$'\036']='^^' [$'\037']='^_' [$'\177']='^?'
  [$'\200']='M-^@' [$'\201']='M-^A' [$'\202']='M-^B' [$'\203']='M-^C'
  [$'\204']='M-^D' [$'\205']='M-^E' [$'\206']='M-^F' [$'\207']='M-^G'
  [$'\210']='M-^H' [$'\211']='M-^I' [$'\212']='M-^J' [$'\213']='M-^K'
  [$'\214']='M-^L' [$'\215']='M-^M' [$'\216']='M-^N' [$'\217']='M-^O'
  [$'\220']='M-^P' [$'\221']='M-^Q' [$'\222']='M-^R' [$'\223']='M-^S'
  [$'\224']='M-^T' [$'\225']='M-^U' [$'\226']='M-^V' [$'\227']='M-^W'
  [$'\230']='M-^X' [$'\231']='M-^Y' [$'\232']='M-^Z' [$'\233']='M-^['
  [$'\234']='M-^\' [$'\235']='M-^]' [$'\236']='M-^^' [$'\237']='M-^_'
  [$'\240']='M- ' [$'\241']='M-!' [$'\242']='M-"' [$'\243']='M-#'
  [$'\244']='M-$' [$'\245']='M-%' [$'\246']='M-&' [$'\247']="M-'"
  [$'\250']='M-(' [$'\251']='M-)' [$'\252']='M-*' [$'\253']='M-+'
  [$'\254']='M-,' [$'\255']='M--' [$'\256']='M-.' [$'\257']='M-/'
  [$'\260']='M-0' [$'\261']='M-1' [$'\262']='M-2' [$'\263']='M-3'
  [$'\264']='M-4' [$'\265']='M-5' [$'\266']='M-6' [$'\267']='M-7'
  [$'\270']='M-8' [$'\271']='M-9' [$'\272']='M-:' [$'\273']='M-;'
  [$'\274']='M-<' [$'\275']='M-=' [$'\276']='M->' [$'\277']='M-?'
  [$'\300']='M-@' [$'\301']='M-A' [$'\302']='M-B' [$'\303']='M-C'
  [$'\304']='M-D' [$'\305']='M-E' [$'\306']='M-F' [$'\307']='M-G'
  [$'\310']='M-H' [$'\311']='M-I' [$'\312']='M-J' [$'\313']='M-K'
  [$'\314']='M-L' [$'\315']='M-M' [$'\316']='M-N' [$'\317']='M-O'
  [$'\320']='M-P' [$'\321']='M-Q' [$'\322']='M-R' [$'\323']='M-S'
  [$'\324']='M-T' [$'\325']='M-U' [$'\326']='M-V' [$'\327']='M-W'
  [$'\330']='M-X' [$'\331']='M-Y' [$'\332']='M-Z' [$'\333']='M-['
  [$'\334']='M-\' [$'\335']='M-]' [$'\336']='M-^' [$'\337']='M-_'
  [$'\340']='M-`' [$'\341']='M-a' [$'\342']='M-b' [$'\343']='M-c'
  [$'\344']='M-d' [$'\345']='M-e' [$'\346']='M-f' [$'\347']='M-g'
  [$'\350']='M-h' [$'\351']='M-i' [$'\352']='M-j' [$'\353']='M-k'
  [$'\354']='M-l' [$'\355']='M-m' [$'\356']='M-n' [$'\357']='M-o'
  [$'\360']='M-p' [$'\361']='M-q' [$'\362']='M-r' [$'\363']='M-s'
  [$'\364']='M-t' [$'\365']='M-u' [$'\366']='M-v' [$'\367']='M-w'
  [$'\370']='M-x' [$'\371']='M-y' [$'\372']='M-z' [$'\373']='M-{'
  [$'\374']='M-|' [$'\375']='M-}' [$'\376']='M-~' [$'\377']='M-^?'
  )

  for ((i = 0; i < ${#line}; i++)); do
    character=${line:i:1}
    if [[ ! $character ]]; then
      escaped_line+='^@'
    else
      escaped_line+=${replacements["$character"]-"$character"}
    fi
  done

  printf %s "$escaped_line"
}


function emit_line {
  typeset line_number=$1 line=$2
  typeset LC_CTYPE=C

  : trailing_newline
  : opt_number_nonblank opt_show_ends opt_number
  : opt_squeeze_blank opt_show_tabs opt_show_nonprinting

  if [[ $opt_show_tabs ]]; then
    line=${line//$'\t'/^I}
  fi

  if [[ $opt_show_nonprinting ]]; then
    IFS= read -r line < <(escape_line "$line")
  fi


  if [[ $opt_number ]]; then
    printf '% 6d\t%s' "$line_number" "$line"
  elif [[ $opt_number_nonblank && $line ]]; then
    printf '% 6d\t%s' "$line_number" "$line"
  elif [[ $opt_number_nonblank ]]; then
    :
  else
    printf '%s' "$line"
  fi

  if [[ $opt_show_ends ]]; then
    printf '$'
  fi

  if [[ $trailing_newline || $opt_show_ends ]]; then
    printf '\n'
  fi
}


function main {
  : <<EOD
  Sample option parsing and automated help generation. This utility
  attempts to imitate GNU cat.

  This shows some of the short-comings of cmdline__*, namely that
  help strings look a bit ugly when they're too long (unless you're
  ok with not wrapping to 80 characters)

  It's also a bit easy to get confused between all these special
  characters, i.e. :'s and ='s.

  Also, it's not a true cat, because it cannot handle NUL bytes (and
  I will not attempt to solve it)
EOD

  typeset IFS type value file line line_number
  typeset opt_number_nonblank opt_show_ends opt_number
  typeset opt_squeeze_blank opt_show_tabs opt_show_nonprinting
  typeset -a files
  typeset version='gcat 0.9'
  typeset -a options=(
  'name=show_all:short=A:long=show-all:help=equivalent to -vET'
  'name=number_nonblank:short=b:long=number-nonblank:help=number '\
'nonempty output lines, overrides -n'
  'name=show_nonprinting_ends:short=e:help=equivalent to -vE'
  'name=show_ends:short=E:long=show-ends:help=display $ at end '\
'of each line'
  'name=number:short=n:long=number:help=number all output lines'
  'name=squeeze_blank:short=s:long=squeeze-blank:help=suppress '\
'repeated empty output lines'
  'name=show_nonprinting_tabs:short=t:help=equivalent to -vT'
  'name=show_tabs:short=T:long=show-tabs:help=display TAB '\
'characters as ^I'
  'name=unknown:short=u:help=(ignored)'
  'name=show_nonprinting:short=v:long=show-nonprinting:help=use ^ '\
'and M- notation, except for LFD and TAB'
  'name=help:long=help:help=display this help and exit'
  'name=version:long=version:help=output version information and exit'
  )

  while read -rd '' type value; do
    case $type in
      @)
        if [[ $value = - ]]; then
          files+=("/dev/stdin")
        else
          files+=("$value")
        fi
        ;;

      -)
        common__die "unknown option ''$value''"
        ;;

      show_all)
        opt_show_ends=y opt_show_tabs=y opt_show_nonprinting=y
        ;;

      number_nonblank)
        opt_number_nonblank=y
        ;;

      show_nonprinting_ends)
        opt_show_ends=y opt_show_nonprinting=y
        ;;

      show_ends)
        opt_show_ends=y
        ;;

      number)
        opt_number=y
        ;;

      squeeze_blank)
        opt_squeeze_blank=y
        ;;

      show_nonprinting_tabs)
        opt_show_tabs=y opt_show_nonprinting=y
        ;;

      show_tabs)
        opt_show_tabs=y
        ;;

      show_nonprinting)
        opt_show_nonprinting=y
        ;;

      help)
        cmdline__help "${options[@]}"; return 0
        ;;

      version)
        printf 'gcat\n'; return 0
        ;;
    esac
  done < <(cmdline__arguments "${options[@]}" -- "$@")

  ((${#files[@]})) || files=(/dev/stdin)

  for file in "${files[@]}"; do
    while IFS= read -r line; do
      if [[ $opt_number_nonblank && $line ]]; then
        ((line_number++))
      elif [[ $opt_number ]]; then
        ((line_number++))
      fi

      trailing_newline=y emit_line "$line_number" "$line"
    done < "$file"

    [[ $line ]] && {
      ((line_number++))

      emit_line "$line_number" "$line"
    }
  done
}

main "$@"
