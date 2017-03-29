Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38597 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbdC2IbE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Mar 2017 04:31:04 -0400
Received: by mail-wm0-f53.google.com with SMTP id t189so18233093wmt.1
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Mar 2017 01:31:02 -0700 (PDT)
Date: Wed, 29 Mar 2017 09:30:58 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        kbuild test robot <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
Message-ID: <20170329083058.6pcslbsq3qnifwjv@dell>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com>
 <20170328082141.u2rgnhei5yhhzxdn@dell>
 <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD69ECA@SW-EX-MBX02.diasemi.com>
 <CAMuHMdU-kaAZ-Reji2v3jSypoDSiwYEWqD0vyYWwJpr6+rAPOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdU-kaAZ-Reji2v3jSypoDSiwYEWqD0vyYWwJpr6+rAPOA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Mar 2017, Geert Uytterhoeven wrote:

> Hi Steve,
>=20
> On Tue, Mar 28, 2017 at 12:42 PM, Steve Twiss
> <stwiss.opensource@diasemi.com> wrote:
> > On 28 March 2017 09:37, Geert Uytterhoeven wrote:
> >> Subject: Re: [PATCH V6 4/7] mfd: da9061: MFD core support
> >> On Tue, Mar 28, 2017 at 10:21 AM, Lee Jones <lee.jones@linaro.org> w=
rote:
> >> >> [auto build test WARNING on ljones-mfd/for-mfd-next]
> >> >> [also build test WARNING on v4.11-rc4 next-20170327]
> >> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.g=
it for-mfd-next
> >> >> config: x86_64-randconfig-x009-201713 (attached as .config)
> >> >> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> >> >> reproduce:
> >> >>         # save the attached .config to linux build tree
> >> >>         make ARCH=3Dx86_64
> >> >>
> >> >> All warnings (new ones prefixed by >>):
> >> >>
> >> >>    drivers//mfd/da9062-core.c: In function 'da9062_i2c_probe':
> >> >> >> drivers//mfd/da9062-core.c:845:21: warning: cast from pointer =
to integer of different size [-Wpointer-to-int-cast]
> >> >>       chip->chip_type =3D (int)match->data;
> >> >>                        ^
> >> >
> >> > Please use longs or enums.
> >>
> >> Enums would still give a warning on 64-bit.
> >> The simple fix is change the cast from (int) to (uintptr_t).
> >
> > Hi Lee and Geert,
> >
> > How about this? Fix by redefining the enum chip_type to be an int.
> > Then, just use substitution:
> > #define COMPAT_TYPE_DA9061  1
> > #define COMPAT_TYPE_DA9062  2
> >
> > That would be simple.
> > Are there any reasons this would not be acceptable?
>=20
> I don't see how that can help.
> The warning is caused by casting the "void *" (which is either 32-bit o=
r
> 64-bit) in of_device_if.data to an integer or enum (which is always 32-=
bit).
>=20
> The right fix is to cast it to uintptr_t intead of int, like other driv=
ers do.

That's a hack though, isn't it?  chip->chip_type is not of type
uintptr_t, so all you're doing here is making the compiler happy.

I see people using (int)(uintptr_t), which I guess keeps the
compiler happy in the first instance and actually culminates in a
correct cast to the right type.

So how about something like (enum da9062_compatible_types)(long)?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
