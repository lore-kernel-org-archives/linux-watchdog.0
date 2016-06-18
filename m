Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33485 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbcFRCgI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 22:36:08 -0400
Date: Fri, 17 Jun 2016 19:36:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160618023607.GA7390@kroah.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
 <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
 <CACRpkdaOzZ1DvEUKtomBU=GH1kYfjKJjUfM-=45PhdzZA=dPgg@mail.gmail.com>
 <20160531112251.GA5674@sophia>
 <20160531152541.GB13304@kroah.com>
 <057d8c0b-074c-609a-35da-5a01f07b6d31@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <057d8c0b-074c-609a-35da-5a01f07b6d31@leemhuis.info>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 12:47:14PM +0200, Thorsten Leemhuis wrote:
> On 31.05.2016 17:25, Greg KH wrote:
> > On Tue, May 31, 2016 at 07:23:06AM -0400, William Breathitt Gray wrot=
e:
> >> On Tue, May 31, 2016 at 10:41:49AM +0200, Linus Walleij wrote:
> >>> On Sat, May 28, 2016 at 12:08 AM, William Breathitt Gray
> >>> <vilhelm.gray@gmail.com> wrote:
> >>>> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> >>>> drivers may be built for X86_64 architectures. This patch changes =
the
> >>>> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API=
, thus
> >>>> allowing them to build for X86_64 as they are expected to.
> > [=E2=80=A6]
> >> Greg K-H,
> >>
> >> Would you be able to pick up this entire patchset via driver-core; I
> >> figure that tree is the most appropriate to receive any core ISA bus
> >> driver changes (unless you see a more fitting path to take).
> > [=E2=80=A6]
> > Yes, I can take this through the driver core tree as that's where the
> > original series came from...
>=20
> Was this series merged or did it fell through the cracks? I currently
> assume the latter, as I can't see it in neither mainline nor linux-next
> (but maybe I'm missing something). Just wondering, because I have this
> issue on my regression list for 4.7.
>=20
> For the whole context see:
> http://thread.gmane.org/gmane.linux.kernel.gpio/17016/
>=20
> Sincerely, your regression tracker for Linux 4.7 (http://bit.ly/28JRmJo=
)

I don't think this is a regression, I was going to queue these up for
4.8-rc1.  As it is now, 4.7-rc is working just fine in this regards,
right?

Or am I missing something?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
