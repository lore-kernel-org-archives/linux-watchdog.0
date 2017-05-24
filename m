Return-path: <esbenhaabendal@gmail.com>
MIME-Version: 1.0
Sender: esbenhaabendal@gmail.com
In-Reply-To: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
From: Esben Haabendal <esben.haabendal@gmail.com>
Date: Wed, 24 May 2017 16:14:30 +0200
Message-ID: <CAOR3GqXU+DO2hw5g+pd+Ax572ccZm18po-eXaZXiGqmE9MaYPg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] watchdog: allow setting deadline for opening /dev/watchdogN
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Guenter Roeck <linux@roeck-us.net>
Content-Type: multipart/alternative; boundary="001a114e25a2380bb2055045bae8"
List-ID: <linux-watchdog@vger.kernel.org>

--001a114e25a2380bb2055045bae8
Content-Type: text/plain; charset="UTF-8"

On 22 May 2017 at 16:06, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
wrote:

>
> Rasmus Villemoes (3):
>   watchdog: introduce watchdog_worker_should_ping helper
>   watchdog: introduce watchdog.open_timeout commandline parameter
>   watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT
>
>  Documentation/watchdog/watchdog-parameters.txt | 10 +++++++
>  drivers/watchdog/Kconfig                       |  9 +++++++
>  drivers/watchdog/watchdog_dev.c                | 37
> +++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 4 deletions(-)
>

Thanks. This is definitely useful for embedded applications.

If this get merged, it should be able to replace several out-of-tree hacks
to accomplish the same thing.

For all 3 patches:
Reviewed-by: Esben Haabendal <esben@haabendal.dk>

/Esben

--001a114e25a2380bb2055045bae8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
2 May 2017 at 16:06, Rasmus Villemoes <span dir=3D"ltr">&lt;<a href=3D"mail=
to:rasmus.villemoes@prevas.dk" target=3D"_blank">rasmus.villemoes@prevas.dk=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Rasmus Villemoes (3):<br>
=C2=A0 watchdog: introduce watchdog_worker_should_ping helper<br>
=C2=A0 watchdog: introduce watchdog.open_timeout commandline parameter<br>
=C2=A0 watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT<br>
<br>
=C2=A0Documentation/watchdog/<wbr>watchdog-parameters.txt | 10 +++++++<br>
=C2=A0drivers/watchdog/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++++<br>
=C2=A0drivers/watchdog/watchdog_dev.<wbr>c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 37 +++++++++++++++++++++++---<br>
=C2=A03 files changed, 52 insertions(+), 4 deletions(-)<br></blockquote></d=
iv><div class=3D"gmail_extra"><br></div>Thanks. This is definitely useful f=
or embedded applications.</div><div class=3D"gmail_extra"><br></div><div cl=
ass=3D"gmail_extra">If this get merged, it should be able to replace severa=
l out-of-tree hacks to accomplish the same thing.</div><div class=3D"gmail_=
extra"><br></div><div class=3D"gmail_extra">For all 3 patches:</div><div cl=
ass=3D"gmail_extra">Reviewed-by: Esben Haabendal &lt;<a href=3D"mailto:esbe=
n@haabendal.dk">esben@haabendal.dk</a>&gt;</div><div class=3D"gmail_extra">=
<br></div><div class=3D"gmail_extra"><div>/Esben</div>
</div></div>

--001a114e25a2380bb2055045bae8--
