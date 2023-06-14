BEGIN {
D["PACKAGE_NAME"]=" \"freeipa\""
D["PACKAGE_TARNAME"]=" \"freeipa\""
D["PACKAGE_VERSION"]=" \"4.11.0.dev202306121608+gitdd2864e3d\""
D["PACKAGE_STRING"]=" \"freeipa 4.11.0.dev202306121608+gitdd2864e3d\""
D["PACKAGE_BUGREPORT"]=" \"https://hosted.fedoraproject.org/projects/freeipa/newticket\""
D["PACKAGE_URL"]=" \"\""
D["PACKAGE"]=" \"freeipa\""
D["VERSION"]=" \"4.11.0.dev202306121608+gitdd2864e3d\""
D["STDC_HEADERS"]=" 1"
D["HAVE_SYS_TYPES_H"]=" 1"
D["HAVE_SYS_STAT_H"]=" 1"
D["HAVE_STDLIB_H"]=" 1"
D["HAVE_STRING_H"]=" 1"
D["HAVE_MEMORY_H"]=" 1"
D["HAVE_STRINGS_H"]=" 1"
D["HAVE_INTTYPES_H"]=" 1"
D["HAVE_STDINT_H"]=" 1"
D["HAVE_UNISTD_H"]=" 1"
D["HAVE_DLFCN_H"]=" 1"
D["LT_OBJDIR"]=" \".libs/\""
D["STDC_HEADERS"]=" 1"
D["HAVE_KDB_FREEPRINCIPAL_EDATA"]=" 1"
D["HAVE_RESOLV_H"]=" 1"
D["USE_PWQUALITY"]=" 1"
D["HAVE_STDARG_H"]=" 1"
D["HAVE_STDDEF_H"]=" 1"
D["HAVE_SETJMP_H"]=" 1"
D["HAVE_DECL_SSS_NSS_GETPWNAM_TIMEOUT"]=" 1"
D["USE_SSS_NSS_TIMEOUT"]=" 1"
D["HAVE_DECL_SSS_NSS_GETORIGBYUSERNAME_TIMEOUT"]=" 1"
D["HAVE_DECL_SSS_NSS_GETORIGBYGROUPNAME_TIMEOUT"]=" 1"
D["HAVE_STRUCT_PAC_DOMAIN_GROUP_MEMBERSHIP"]=" 1"
D["HAVE_PAC_UPN_DNS_INFO_EX"]=" 1"
D["HAVE_PAC_REQUESTER_SID"]=" 1"
D["HAVE_PAC_ATTRIBUTES_INFO"]=" 1"
D["HAVE_PDB_ENUM_UPN_SUFFIXES"]=" 1"
D["HAVE_SMBLDAP_GET_LDAP"]=" 1"
D["HAVE_SMBLDAP_SET_BIND_CALLBACK"]=" 1"
D["HAVE_UNICASE_H"]=" 1"
D["HAVE_KRB5_CERTAUTH_PLUGIN"]=" 1"
D["ENABLE_NLS"]=" 1"
D["HAVE_GETTEXT"]=" 1"
D["HAVE_DCGETTEXT"]=" 1"
  for (key in D) D_is_set[key] = 1
  FS = ""
}
/^[\t ]*#[\t ]*(define|undef)[\t ]+[_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ][_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]*([\t (]|$)/ {
  line = $ 0
  split(line, arg, " ")
  if (arg[1] == "#") {
    defundef = arg[2]
    mac1 = arg[3]
  } else {
    defundef = substr(arg[1], 2)
    mac1 = arg[2]
  }
  split(mac1, mac2, "(") #)
  macro = mac2[1]
  prefix = substr(line, 1, index(line, defundef) - 1)
  if (D_is_set[macro]) {
    # Preserve the white space surrounding the "#".
    print prefix "define", macro P[macro] D[macro]
    next
  } else {
    # Replace #undef with comments.  This is necessary, for example,
    # in the case of _POSIX_SOURCE, which is predefined and required
    # on some systems where configure will not decide to define it.
    if (defundef == "undef") {
      print "/*", prefix defundef, macro, "*/"
      next
    }
  }
}
{ print }
