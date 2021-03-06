#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the demo8-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the demo8-1.0.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "demo8 Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the demo8 will be installed in:"
    echo "  \"${toplevel}/demo8-1.0.1-Linux\""
    echo "Do you want to include the subdirectory demo8-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/demo8-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +167 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the demo8-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� 9Cu_ �[p�w��� �C"Һ�q ��ʏ�KraC����6�����r��$a�2�:s�(3��h;��L������`�N��3V;VgЂP���-r�����v_v	8�V�/�~�}���~�~�w7���3�|�`������\#�_����k�~��������a�fd1MI�����q�Ѹ��\����P?��4���:���Y��W,�@��`M q��l����"��j�ٴ�ݏpʽHM7�ҭ�FԀ����
a�"��/ٌ�T�G�k��i��BFn��������4=���r/�|��;b7�ى�Q�w��S>C6�����zHy,oAF^Dx�9��w��i�[�}��k'7�ݤ>�q�#���΃7ﯯ�&�Չx2;R=�P_]_�ɤ<�Mn"���W���M��/#�ſ��g"�F^�����_}�U�/��k�NDg�H��w�	��w[�>�a�zWYȏZ���;Mp��#xx��pVΠ�t<)ǐ(��K	BdDb񤘈� ����O�-�mM�B���!���C�Jii ���tOGs"��z���J%�����
*d'��ٔ���]/�xI�uE��]��#>Es�ۈ���+T���k����:\o'3:�T�_��e:��KPa=c���~R���)^����OK��N�OM���?�z餖���Pơ|��p����pzg�=��:��xH�N)�p7�섒~�q�U�X?v���?ߖ{k7���;=���~��E����(l�Ǹ��t>���E�ބD/��8p~�%>wF����L�B��������'��wM�VҠ�Â�~���
��ǯ8��|z3o;��uE��C��%�@���oZb(���6��w��=K��VBj�z<���D�RH۰�~���dL��u6�f�1��}>����������� ��U~��ϝ�.�n�al��+�<R�^в��c��<����D�"��td����'�\x��Iy��PXԧ� y��S�ɽ�'/T��'�7B���K�D�bkN�����n^�|	m­{s��B���tn�i,8}���	(jl�i�uŔ�'����;q |yC���*���,�C�'*��C�B;�r�zC���<��R��|{(�e[�b��3ʚ?��c:��2�����ܿ�s[r嗽ϏM���d�a����C�]��!a�Pa�?�$6D��F��*��ҙx*�UE=UQ'�͈�}d���F�agKʜ�8t��p{$.9�l�K�Ir�<����ӣUp��,.��4oC��Ͷ�Z�m�na;rY�c�����?�e��॰��0�#�w�Mm)Ѷ��Fܶۖ�����1��-]P�=�������O�;���.w��rk��=�������u'���9�~�u�߹�j[Q��~��\���	Ԡ����אߥ��2�G�GG������U��#��5��<S̻|O/�]c%�ƴ�!��\k�\ȁ|��Ty���_%��~�]��6���?�?aZB�!��7�M��ۨ�uIS�^I8��V1�_\�+����بOu�89ԗ:F��F�<�	�$�d$�+���t�t?�>�
�}�F|����	©�F��.2��6���F�+$�E����!�$��$���n$�s&K'H��!�c�/^�p|�~������5��٤�傞:���&�����<�ڵ*z-e:`�L6i�r�)�@�)^��?#^��;#�H[�F�D�7#^�ͷ/�֕wj�ψ/��Ј/AGM�r�aD�]Z�ňWhvm���)�T��и)~��O�e��`�o1]��\�g#��6�+���u����#��x�ø52��"�~���ST�(���}�r?{�H9����m&�yآ���U_V�nB�;�s�	�z�����3{�#�l��+W�ue��g��r��8��I��n�;	�Kp��<.���~:l���Ԇc+f�7N��m_#�<c����϶�E�� |�}���Rz�:����_ɸ���a���U2�D��~B�
��Tyv�D~%Y�3/���w�]m?[Νv��n��Ƿ�+��쟑������'�
+A"8�A�M	�T���r*��������,E=����B8X�tZ���E��8$	����(��RH�QR�D"
[�Ɉ'ˌ'2<��ݡ���l��3�j	-v�:ښ�9J��-��B�'%�-�H�Ҿ�)�.lkm��zBM�a�F�"���	$��n8�GJG�W���ac�>��FD���,��"����l��u�E���0(&�8�ض2�� �먾3xD ݟɐb��%�o�UA��[(�!Qc	ȓ��~�rZ��z.���'��%O���ZHj ���g�hu<��Ԡ�D��h�S��VsS��� yi)!bAr7��q��q|�H��,��U�ZO:�L�G$+r0�.�TUu��j���Q�aL��b֯��]/�s~6�����%6��c�����g�0?�O�F��C�#.��N��y�i?ݎX�
�gX�������}�Ƨ�>=��@�w"�_����(���g�O�Z�鹉����G�z֡i��R�Y���^��)է~2�L�l��$��� ��)���/7���a����9�;�9F���w1�n�����n�{F���?c����טs�ۘD�`���B9랱��2�/�3(�h?��}���V���ѧ���0���M���Z�@{oi.ώ���W�ӧ~�k���cO���4}��ѣ��64;�1^���������nc=�>��Q}꿹��������@ �_k���f��F��G?g�E���L�v=�/W�N�p��K-�/�
�0���������/�+��:|>_}m���_55�z���`]M���?_ݱQLG�wz9#�f��x@��l/�N!��8��f��<)����5�Z��&mc�����F�rb�n�h$�r���n�^�Q�����v�zˇ�V깚���"�(&���簈y;f=�)n�v�ܼ�����G
���$��n�j�<��u��*q:�� �ʩQ9̩7݉�����K=F�1����#DM;�� ��7x����!��0~���TI�>���O��z���l���U�����8L��wGi=2�n�	_gQ?�M&m��L�G�d��)��m72�?�������g坕үI���L���3��w�Z�3�4�uP�����S<Id�Ҽ��W��?�]���� :�����c��WSP�������������?y�Np՛Ӓ(KQ��+��K%����7��ӹ:KF��uw
���P�����Ӷ�s��;W�@<)]UƹZJF�1��jI���m��u%Ӵ\-)�䢩lB��nI�/����IY��o�Z�{�����$���n�����}�t���`�������D��w;X����xC���'�Y%D9�Jq���c�bg\�<(6;���Y�L�Ў� �ɭ�*%`euQeӰ����''&�\F��xr �A�\OVN��bB�o��hp�v�`Sغ���[d�uB����Z�Z�����Z�g >  