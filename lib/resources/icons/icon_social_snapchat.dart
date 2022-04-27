import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_interface.dart';

// THIS FILE IS AUTO-GENERATED by rate_club/scripts/icons_generator.py

class IconSocialSnapchat extends StatelessWidget implements IconInterface {
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  static const _svgString = '''
	<svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0 20C0 8.95431 8.95431 0 20 0C31.0457 0 40 8.95431 40 20C40 31.0457 31.0457 40 20 40C8.95431 40 0 31.0457 0 20Z" fill="black"/><path d="M28.5102 25.3123C25.2582 23.7381 24.7399 21.3075 24.7168 21.1272C24.6889 20.9089 24.6572 20.7372 24.8982 20.5151C25.1305 20.3004 26.1612 19.6625 26.4472 19.4629C26.9198 19.1324 27.128 18.8024 26.9746 18.3968C26.8673 18.1162 26.606 18.0105 26.3307 18.0105C26.2439 18.0107 26.1574 18.0204 26.0726 18.0394C25.5533 18.1521 25.0489 18.4123 24.757 18.4826C24.722 18.4917 24.6859 18.4965 24.6497 18.4971C24.4941 18.4971 24.4351 18.4279 24.4501 18.2406C24.4866 17.673 24.5639 16.565 24.4743 15.53C24.3514 14.106 23.8921 13.4005 23.3475 12.7765C23.0841 12.4739 21.8608 11.1738 19.5 11.1738C17.1392 11.1738 15.9175 12.4739 15.6557 12.7727C15.1095 13.3967 14.6507 14.1023 14.5289 15.5263C14.4393 16.5613 14.5198 17.6687 14.5531 18.2369C14.5638 18.415 14.5091 18.4934 14.3535 18.4934C14.3172 18.4927 14.2812 18.4879 14.2462 18.4789C13.9548 18.4086 13.4505 18.1484 12.9311 18.0357C12.8464 18.0167 12.7598 18.007 12.673 18.0067C12.3967 18.0067 12.1365 18.114 12.0292 18.393C11.8757 18.7986 12.0828 19.1286 12.5571 19.4591C12.8431 19.6587 13.8738 20.2961 14.1061 20.5113C14.3465 20.7334 14.3154 20.9051 14.2875 21.1235C14.2644 21.3065 13.7456 23.737 10.4941 25.3085C10.3036 25.4008 9.97956 25.5961 10.551 25.9116C11.4481 26.4074 12.0452 26.3543 12.5094 26.6531C12.9032 26.9069 12.6703 27.4542 12.9568 27.6516C13.3088 27.8947 14.3492 27.6344 15.6932 28.0782C16.82 28.4495 17.5046 29.4984 19.5027 29.4984C21.5008 29.4984 22.2052 28.4446 23.3121 28.0782C24.6535 27.6344 25.696 27.8947 26.0485 27.6516C26.3345 27.4542 26.1022 26.9069 26.496 26.6531C26.9601 26.3543 27.5567 26.4074 28.4544 25.9116C29.0247 25.5999 28.7006 25.4046 28.5102 25.3123Z" fill="white"/><path d="M29.9249 25.1273C29.779 24.7303 29.5011 24.5178 29.1845 24.3418C29.1249 24.3069 29.0702 24.279 29.0235 24.2576C28.9291 24.2087 28.8325 24.1615 28.7365 24.1116C27.7498 23.5885 26.9793 22.9285 26.4449 22.1463C26.2931 21.926 26.1615 21.6926 26.0516 21.4488C26.006 21.3184 26.0082 21.2443 26.0409 21.1767C26.0734 21.1246 26.1163 21.0799 26.167 21.0453C26.3365 20.9331 26.5114 20.8194 26.63 20.7427C26.8414 20.6058 27.0088 20.4975 27.1167 20.4207C27.5217 20.1374 27.805 19.8364 27.9821 19.5C28.1056 19.2676 28.1777 19.0113 28.1933 18.7486C28.209 18.4858 28.1679 18.2228 28.0728 17.9773C27.8045 17.2712 27.1376 16.8329 26.3296 16.8329C26.1591 16.8327 25.9891 16.8507 25.8225 16.8865C25.778 16.8962 25.7335 16.9064 25.69 16.9177C25.6975 16.4348 25.6868 15.925 25.6438 15.4234C25.4915 13.6598 24.8739 12.7353 24.2301 11.9981C23.8178 11.5361 23.3321 11.1453 22.7927 10.8413C21.8156 10.2833 20.7077 10 19.4999 10C18.2921 10 17.1895 10.2833 16.2114 10.8413C15.6707 11.1454 15.184 11.537 14.7713 12.0002C14.1275 12.7374 13.5099 13.6635 13.3576 15.4255C13.3146 15.9272 13.3039 16.4396 13.3109 16.9198C13.2674 16.9085 13.2234 16.8983 13.1789 16.8887C13.0123 16.8528 12.8423 16.8349 12.6718 16.835C11.8633 16.835 11.1953 17.2734 10.9281 17.9795C10.8326 18.225 10.7911 18.4882 10.8063 18.7513C10.8216 19.0143 10.8933 19.2709 11.0166 19.5038C11.1942 19.8402 11.4775 20.1412 11.8826 20.4245C11.9899 20.4996 12.1578 20.608 12.3692 20.7464C12.4835 20.8205 12.6504 20.9288 12.814 21.0372C12.8713 21.0742 12.92 21.1231 12.9568 21.1805C12.9911 21.2508 12.9922 21.3264 12.9412 21.4659C12.8328 21.7046 12.7033 21.9332 12.5543 22.1489C12.0318 22.9135 11.2838 23.5617 10.3288 24.0805C9.82281 24.3488 9.29699 24.528 9.07487 25.1316C8.90746 25.5871 9.01692 26.1054 9.4424 26.5422C9.59855 26.7052 9.77967 26.8423 9.97894 26.9483C10.3936 27.1762 10.8345 27.3526 11.2919 27.4736C11.3862 27.4979 11.4759 27.538 11.5569 27.5922C11.712 27.7279 11.69 27.9323 11.8965 28.2317C12.0002 28.3865 12.132 28.5204 12.285 28.6266C12.7185 28.926 13.2057 28.9448 13.7219 28.9647C14.1881 28.9824 14.7166 29.0027 15.3202 29.2018C15.5703 29.2844 15.8299 29.4443 16.1309 29.631C16.8537 30.0753 17.8431 30.6832 19.4988 30.6832C21.1546 30.6832 22.151 30.0721 22.879 29.6262C23.1779 29.4427 23.436 29.2844 23.679 29.204C24.2826 29.0044 24.8111 28.9845 25.2774 28.9668C25.7935 28.9469 26.2807 28.9282 26.7143 28.6288C26.8955 28.5024 27.0464 28.3375 27.1564 28.1459C27.305 27.8932 27.3012 27.7167 27.4407 27.5932C27.5168 27.5417 27.6009 27.5032 27.6897 27.4795C28.1533 27.3581 28.6002 27.1801 29.0203 26.9494C29.232 26.8358 29.4226 26.6866 29.5837 26.5084L29.5891 26.5019C29.9882 26.0748 30.0886 25.5716 29.9249 25.1273ZM28.4532 25.9182C27.5556 26.4139 26.9589 26.3608 26.4948 26.6597C26.1004 26.9134 26.3338 27.4607 26.0473 27.6582C25.6954 27.9012 24.655 27.641 23.311 28.0847C22.2025 28.4512 21.4953 29.505 19.5015 29.505C17.5077 29.505 16.8172 28.4533 15.6904 28.082C14.3491 27.6383 13.3066 27.8985 12.9541 27.6555C12.6681 27.458 12.9004 26.9108 12.5066 26.657C12.0419 26.3581 11.4453 26.4112 10.5482 25.9182C9.97679 25.6027 10.3009 25.4074 10.4913 25.3151C13.7428 23.7409 14.2616 21.3103 14.2847 21.1301C14.3126 20.9117 14.3437 20.74 14.1033 20.5179C13.871 20.3032 12.8403 19.6653 12.5543 19.4657C12.0811 19.1352 11.8729 18.8052 12.0264 18.3996C12.1337 18.119 12.3955 18.0133 12.6702 18.0133C12.7571 18.0135 12.8436 18.0233 12.9283 18.0422C13.4477 18.1549 13.952 18.4151 14.2434 18.4854C14.2785 18.4944 14.3145 18.4993 14.3507 18.4999C14.5063 18.4999 14.561 18.4216 14.5503 18.2434C14.517 17.6753 14.4365 16.5678 14.5261 15.5328C14.649 14.1088 15.1078 13.4033 15.6529 12.7793C15.9147 12.4794 17.145 11.1793 19.4977 11.1793C21.8505 11.1793 23.084 12.474 23.3458 12.7729C23.8915 13.3969 24.3508 14.1024 24.4726 15.5264C24.5622 16.5614 24.4849 17.6693 24.4484 18.237C24.4361 18.4243 24.4924 18.4935 24.648 18.4935C24.6842 18.4929 24.7203 18.488 24.7553 18.479C25.0472 18.4087 25.5516 18.1485 26.0709 18.0358C26.1557 18.0168 26.2422 18.0071 26.329 18.0068C26.6053 18.0068 26.8656 18.1141 26.9729 18.3931C27.1263 18.7988 26.9192 19.1287 26.4454 19.4593C26.1595 19.6588 25.1288 20.2963 24.8964 20.5114C24.6555 20.7335 24.6872 20.9052 24.7151 21.1236C24.7382 21.3066 25.2565 23.7371 28.5085 25.3086C28.7005 25.4047 29.0246 25.6 28.4532 25.9182Z" fill="black"/></svg>
    ''';

  const IconSocialSnapchat({Key? key, this.height, this.width, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _svgString,
      color: color,
      height: size ?? height,
      width: size ?? width,
    );
  }
}

    