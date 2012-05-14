Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:41425 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756341Ab2ENNeq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 09:34:46 -0400
Date: Mon, 14 May 2012 15:34:44 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomasw@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-watchdog@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/9] watchdog-kernel-api.txt: Document new watchdog_dev fields
Message-ID: <20120514133444.GI3074@spo001.leaseweb.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com> <1336730427-1664-4-git-send-email-hdegoede@redhat.com> <CA+i0qc6FEdFomBn6_HDGsXYiVQa0gtbELpkjNK6dqy5aoaoytA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CA+i0qc6FEdFomBn6_HDGsXYiVQa0gtbELpkjNK6dqy5aoaoytA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Tomas,

> On Fri, May 11, 2012 at 1:00 PM, Hans de Goede <hdegoede@redhat.com> wr=
ote:
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > =A0Documentation/watchdog/watchdog-kernel-api.txt | =A0 11 ++++++++++=
-
> > =A01 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documen=
tation/watchdog/watchdog-kernel-api.txt
> > index 227f6cd..03aa948 100644
> > --- a/Documentation/watchdog/watchdog-kernel-api.txt
> > +++ b/Documentation/watchdog/watchdog-kernel-api.txt
> > @@ -1,6 +1,6 @@
> > =A0The Linux WatchDog Timer Driver Core kernel API.
> > =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -Last reviewed: 16-Mar-2012
> > +Last reviewed: 11-May-2012
> >
> > =A0Wim Van Sebroeck <wim@iguana.be>
> >
> > @@ -46,6 +46,10 @@ struct watchdog_device {
> > =A0 =A0 =A0 =A0unsigned int min_timeout;
> > =A0 =A0 =A0 =A0unsigned int max_timeout;
> > =A0 =A0 =A0 =A0void *driver_data;
> > + =A0 =A0 =A0 int id;
> > + =A0 =A0 =A0 struct cdev cdev;
> > + =A0 =A0 =A0 struct device *dev;
> > + =A0 =A0 =A0 struct device *busdev;
> > =A0 =A0 =A0 =A0unsigned long status;
> > =A0};
>=20
> I would split this patch into two according the original patches that
> add the code to not complicate a possible rollback of an patch.

Will take care of it.

Kind regards,
Wim.

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
