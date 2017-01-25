Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <74bfcbb3-a9ce-8228-77d3-db4defa79df5@roeck-us.net>
References: <1485248322-24299-1-git-send-email-baoyou.xie@linaro.org>
 <1485248322-24299-3-git-send-email-baoyou.xie@linaro.org> <35dcd00f-a4bd-a313-0d6f-932a3f5888f0@roeck-us.net>
 <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com> <74bfcbb3-a9ce-8228-77d3-db4defa79df5@roeck-us.net>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Wed, 25 Jan 2017 10:47:26 +0800
Message-ID: <CA+DQWkytLtmEzCrxLh=R1GntqKC6doM1O7ekEn8_tNVQb8BPkQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a1140b0fac6481f0546e240e2
List-ID: <linux-watchdog@vger.kernel.org>

--001a1140b0fac6481f0546e240e2
Content-Type: text/plain; charset=UTF-8

On 25 January 2017 at 10:43, Guenter Roeck <linux@roeck-us.net> wrote:

> On 01/24/2017 06:16 PM, Baoyou Xie wrote:
>
>>
>> [ ... ]
>
>>         +
>>         +       ret = of_parse_phandle_with_fixed_args(dev->of_node,
>>         +                       "zte,wdt-reset-sysctrl", 3, 0, &out_args);
>>         +       if (ret)
>>         +               return;
>>         +
>>         +       offset = out_args.args[0];
>>         +       config = out_args.args[1];
>>         +       mask = out_args.args[2];
>>         +
>>         +       regmap = syscon_node_to_regmap(out_args.np <
>> http://out_args.np>);
>>         +       if (IS_ERR(regmap))
>>         +               return;
>>         +
>>         +       regmap_update_bits(regmap, offset, mask, config);
>>
>>
>>     Another comment suggested adding
>>             of_node_put(out_args.np <http://out_args.np>);
>>     here.
>>
>>
>> is it really? most of the driver that call this function don't call
>> of_node_put. but it seems harmless to call of_node_put.
>>
>>
>> Even if everyone else is doing things wrong, that doesn't mean
> that you should do the same, nor is it a good idea to use it
> as argument.
>
> en, yes.
I have read the comment of of_parse_phandle_with_fixed_args. in v6 version,
I have fixed it.
thanks.


> Guenter
>
>

--001a1140b0fac6481f0546e240e2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 25 January 2017 at 10:43, Guenter Roeck <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 01/=
24/2017 06:16 PM, Baoyou Xie wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote>
[ ... ]<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_parse_ph=
andle_with_fixed_ar<wbr>gs(dev-&gt;of_node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;zte,wdt-reset-sysctrl&quot;, 3,=
 0, &amp;out_args);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D out_args=
.args[0];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0config =3D out_args=
.args[1];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D out_args.a=
rgs[2];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap =3D syscon_n=
ode_to_regmap(<a href=3D"http://out_args.np" rel=3D"noreferrer" target=3D"_=
blank">out_args<wbr>.np</a> &lt;<a href=3D"http://out_args.np" rel=3D"noref=
errer" target=3D"_blank">http://out_args.np</a>&gt;);<span class=3D"gmail-"=
><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(regmap))=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0regmap_update_bits(=
regmap, offset, mask, config);<br>
<br>
<br>
=C2=A0 =C2=A0 Another comment suggested adding<br></span>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of_node_put(<a href=3D"http://out=
_args.np" rel=3D"noreferrer" target=3D"_blank">out_args.np</a> &lt;<a href=
=3D"http://out_args.np" rel=3D"noreferrer" target=3D"_blank">http://out_arg=
s.np</a>&gt;);<span class=3D"gmail-"><br>
=C2=A0 =C2=A0 here.<br>
<br>
<br>
is it really? most of the driver that call this function don&#39;t call of_=
node_put. but it seems harmless to call of_node_put.<br>
<br>
<br>
</span></blockquote>
Even if everyone else is doing things wrong, that doesn&#39;t mean<br>
that you should do the same, nor is it a good idea to use it<br>
as argument.<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br></font></span></blockquote><div>en, yes.<br></div><div>I have read the =
comment of <span class=3D"gmail-">of_parse_phandle_with_fixed_ar<wbr>gs. in=
 v6 version, I have fixed it.<br></span></div><div><span class=3D"gmail-">t=
hanks.<br></span></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#888888">
Guenter<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a1140b0fac6481f0546e240e2--
