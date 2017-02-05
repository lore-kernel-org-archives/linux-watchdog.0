Return-path: <baoyou.xie@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170205034504.GD3407@dragon>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org> <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
 <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com> <20170205034504.GD3407@dragon>
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Sun, 5 Feb 2017 11:57:28 +0800
Message-ID: <CA+DQWkzUXd119PNv=SkdkvwQ_4EjQLW0soiCgSdg0UDACXGUow@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver
 to ARM ZTE architecture
To: Shawn Guo <shawnguo@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>,
	chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Content-Type: multipart/alternative; boundary=001a114acbf07d65260547c08350
List-ID: <linux-watchdog@vger.kernel.org>

--001a114acbf07d65260547c08350
Content-Type: text/plain; charset=UTF-8

On 5 February 2017 at 11:45, Shawn Guo <shawnguo@kernel.org> wrote:

> Hi Baoyou,
>
> On Sun, Feb 05, 2017 at 10:36:38AM +0800, Baoyou Xie wrote:
> > On 5 February 2017 at 08:05, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On 02/03/2017 05:34 PM, Baoyou Xie wrote:
> > >
> > >> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
> > >> architecture maintainers, as they're parts of the core IP.
> > >>
> > >> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > >>
> > >
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > I assume you'll submit this patch through the arm tree ?
> > >
> > Could you please submit all three patches through your tree? Thanks a lot
> > :)
>
> Patch #2 is the only one that Guenter is concerned about, as there are
> other subsystem related updates on the file.  I think Guenter's
> suggestion is good, i.e. we have patch #1 and #3 go upstream through
> watchdog tree, and later we update MAINTAINERS as needed via arm-soc
> tree.
>
> That's great :) It's better to submit this patch through *arm-soc* tree.



> Shawn
>

--001a114acbf07d65260547c08350
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 5 February 2017 at 11:45, Shawn Guo <span dir=3D"ltr">&lt;<a href=3D=
"mailto:shawnguo@kernel.org" target=3D"_blank">shawnguo@kernel.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Baoyo=
u,<br>
<span class=3D"gmail-"><br>
On Sun, Feb 05, 2017 at 10:36:38AM +0800, Baoyou Xie wrote:<br>
&gt; On 5 February 2017 at 08:05, Guenter Roeck &lt;<a href=3D"mailto:linux=
@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On 02/03/2017 05:34 PM, Baoyou Xie wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; Add the zx2967 watchdog controller driver as maintained by AR=
M ZTE<br>
&gt; &gt;&gt; architecture maintainers, as they&#39;re parts of the core IP=
.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Baoyou Xie &lt;<a href=3D"mailto:baoyou.xie@li=
naro.org">baoyou.xie@linaro.org</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.n=
et">linux@roeck-us.net</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; I assume you&#39;ll submit this patch through the arm tree ?<br>
&gt; &gt;<br>
&gt; Could you please submit all three patches through your tree? Thanks a =
lot<br>
&gt; :)<br>
<br>
</span>Patch #2 is the only one that Guenter is concerned about, as there a=
re<br>
other subsystem related updates on the file.=C2=A0 I think Guenter&#39;s<br=
>
suggestion is good, i.e. we have patch #1 and #3 go upstream through<br>
watchdog tree, and later we update MAINTAINERS as needed via arm-soc<br>
tree.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div>That&#39;s great :) It&#39;s better to submit this patch <spa=
n class=3D"gmail-">through</span> *arm-soc* tree.<br></div><div><br>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail=
-HOEnZb"><font color=3D"#888888">
Shawn<br>
</font></span></blockquote></div><br></div></div>

--001a114acbf07d65260547c08350--
