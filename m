Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54442 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932934AbdCaPF3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 11:05:29 -0400
Date: Fri, 31 Mar 2017 08:05:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Tim Small <tim@seoss.co.uk>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Brandon <tbrandonau@gmail.com>,
        Eddi De Pieri <eddi@depieri.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
Message-ID: <20170331150524.GA31555@roeck-us.net>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
 <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
 <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 04:46:02PM +0200, Boszormenyi Zoltan wrote:
> 2017-03-31 14:49 keltez=C3=A9ssel, Guenter Roeck =C3=ADrta:
> >Hi Paul,
> >
> >On 03/31/2017 12:17 AM, Paul Menzel wrote:
> >>Dear Wolfram,
> >>
> >>
> >>Thank you for the reply, which we talked about briefly at the
> >>Chemnitzer LinuxTage.
> >>
> >>
> >>Am Freitag, den 03.03.2017, 11:17 +0100 schrieb Wolfram Sang:
> >>>>Unfortunately, commit 2fee61d22e (i2c: piix4: Add support for
> >>>>multiplexed main adapter in SB800) [1] caused a regression. Tim
> >>>>reported that to the Linux Kernel Bugtracker as bug #170741 last
> >>>>September [2], but it looks like the affected subsystems don=E2=80=99=
t use it.
> >>>
> >>>Jean Delvare pointed out this issue amongst others[1] last year alre=
ady.
> >>>Let me quote:
> >>>
> >>>=3D=3D=3D
> >>>
> >>>5* The I/O ports used for SMBus configuration and port switching are
> >>>also needed by a watchdog driver, sp5100_tco. Both drivers request t=
he
> >>>region, so the first one wins, and the other driver can't be loaded.
> >>>sp5100_tco was there first, so the changes done to the i2c-piix4 dri=
ver
> >>>recently will cause a regression for some users by preventing them
> >>>from using the sp5100_tco and i2c-piix4 drivers at the same time. In
> >>>the long run I guess we will need a helper module to handle this sha=
red
> >>>resource. Unless IORESOURCE_MUXED can be used for that. Either way,
> >>>that's more work than I can put into this before kernel v4.5 is
> >>>released. For the time being, I think we should simply make it
> >>>non-fatal if the I/O ports can't be requested, and continue without
> >>>multiplexing (as before.)
> >>>
> >>>=3D=3D=3D
> >>>
> >>>Seems nobody had the resources, so far.
> >>
> >>I still don=E2=80=99t understand, why Jean then not immediately rever=
ted the
> >>commit to adhere to the Linux Kernel=E2=80=99s no-regression-policy.
> >>
> >>>I don't have the HW and not much experience with non-embedded
> >>>platforms. I wonder, though, if we really need to convert the driver=
s
> >>>to MFD ones, or if we could use the simpler MFD_SYSCON mechanism
> >>>which helps in exactly such cases for embedded platforms. But I am
> >>>really lacking details here and am afraid this is probably all the
> >>>input I can give currently.
> >>
> >>Zoltan stepped up, and uploaded a patch for review to the Kernel.org
> >>Bugzilla [2], also attached to this message.
> >>
> >
> >Please don't send patches as attachments.
> >
> >request_muxed_region() can fail, and literally every other driver
> >using it checks for that failure. Please do the same.
>=20
> In what circumstances can request_muxed_region() fail? As far as
> I can see, only if two drivers use the same I/O port base and the
> already present region did not use IORESOURCE_MUXED which is
> not the case here. When request_muxed_region() is used consistently,
> subsequent requests are put on a wait queue and the first one is
> woken up when the region is released. So, it's basically a mutex.
> Am I missing something here?
>=20

Yes. failure to allocate the resource is one. The other is that you are
making the assumption that all other requesters have IORESOURCE_MUXED set=
.
There is no guarantee that this is the case.

Guenter

> Alternatively, the original "piix4_mutex_sb800" mutex can be moved out
> to its own file and used by both drivers. This way, request_muxed_regio=
n()
> would not be needed at all among these two drivers.
>=20
> The third option is to remove the request_*region() calls and the mutex
> completely.
>=20
> After all, drivers/usb/host/pci-quirks.c::usb_amd_quirk_pll() also uses
> this I/O port pair and this is done without request_*region() or lockin=
g.
> It is for some AMD devices, SB800 included, for which the function
> accesses the same I/O ports used by both i2c-piix4 and sp5100_tco.
>=20
> /*
>  * The hardware normally enables the A-link power management feature, w=
hich
>  * lets the system lower the power consumption in idle states.
>  *
>  * This USB quirk prevents the link going into that lower power state
>  * during isochronous transfers.
>  *
>  * Without this quirk, isochronous stream on OHCI/EHCI/xHCI controllers=
 of
>  * some AMD platforms may stutter or have breaks occasionally.
>  */
> static void usb_amd_quirk_pll(int disable)
>=20
> This function is hidden behind two wrappers: usb_amd_quirk_pll_disable(=
)
> and usb_amd_quirk_pll_enable() and these are used from:
>=20
> drivers/usb/host/ohci-q.c
> drivers/usb/host/xhci-ring.c
> drivers/usb/host/ehci-sched.c
>=20
> >The sp5100_tco_dev_name change in the watchdog driver is unnecessary.
>=20
> request_muxed_region() requires a const char * name to be passed.
> sp5100_tco uses a different DEVNAME for the two device generations.
> I wanted to preserve this distinction but dev_name is local to
> sp5100_tco_setupdevice() and it would have been an overkill to call
> tco_has_sp5100_reg_layout() every time the code executes
> request_muxed_region().
>=20
> Are you saying that this distinction is unnecessary, too?
> I would prefer a single DEVNAME that just contains the driver name.
> Less code, less confusion.
>=20
> >There are some unnecessary { } in the watchdog driver after the patch
> >is applied.
>=20
> True, there are two places.
>=20
> >Please split the patch into two patches so they can be reviewed and
> >applied separately.
>=20
> Likely I will, but I would like to hear the others' opinion, too.
>=20
> 1. a single patch with a single goal: protect I/O port access
>    for SB800 across the whole kernel
> 2. patch series for same goal for the two drivers separately
>    (or three if pci-quirks.c needs to change as well)
>=20
> and
>=20
> A) a common mutex across the two (three) drivers in the kernel, or
> B) request_muxed_region() with retrying in the usual manner if it fails=
:
>=20
>    #define enter_sb800() \
>       do { \
>       } while (!request_muxed_region(...))
>=20
> Best regards,
> Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
