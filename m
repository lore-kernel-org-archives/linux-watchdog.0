Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34076 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933317AbdCaMt5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 08:49:57 -0400
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
To: Paul Menzel <paulepanter@users.sourceforge.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Zoltan Boszormenyi <zboszor@pr.hu>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
 <20170303101702.GA1669@katana>
 <1490944639.2653.182.camel@users.sourceforge.net>
Cc: Christian Fetzer <fetzer.ch@gmail.com>,
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
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
Date: Fri, 31 Mar 2017 05:49:50 -0700
MIME-Version: 1.0
In-Reply-To: <1490944639.2653.182.camel@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 03/31/2017 12:17 AM, Paul Menzel wrote:
> Dear Wolfram,
>
>
> Thank you for the reply, which we talked about briefly at the
> Chemnitzer LinuxTage.
>
>
> Am Freitag, den 03.03.2017, 11:17 +0100 schrieb Wolfram Sang:
>>> Unfortunately, commit 2fee61d22e (i2c: piix4: Add support for
>>> multiplexed main adapter in SB800) [1] caused a regression. Tim
>>> reported that to the Linux Kernel Bugtracker as bug #170741 last
>>> September [2], but it looks like the affected subsystems don=E2=80=99=
t use it.
>>
>> Jean Delvare pointed out this issue amongst others[1] last year alread=
y.
>> Let me quote:
>>
>> =3D=3D=3D
>>
>> 5* The I/O ports used for SMBus configuration and port switching are
>> also needed by a watchdog driver, sp5100_tco. Both drivers request the
>> region, so the first one wins, and the other driver can't be loaded.
>> sp5100_tco was there first, so the changes done to the i2c-piix4 drive=
r
>> recently will cause a regression for some users by preventing them
>> from using the sp5100_tco and i2c-piix4 drivers at the same time. In
>> the long run I guess we will need a helper module to handle this share=
d
>> resource. Unless IORESOURCE_MUXED can be used for that. Either way,
>> that's more work than I can put into this before kernel v4.5 is
>> released. For the time being, I think we should simply make it
>> non-fatal if the I/O ports can't be requested, and continue without
>> multiplexing (as before.)
>>
>> =3D=3D=3D
>>
>> Seems nobody had the resources, so far.
>
> I still don=E2=80=99t understand, why Jean then not immediately reverte=
d the
> commit to adhere to the Linux Kernel=E2=80=99s no-regression-policy.
>
>> I don't have the HW and not much experience with non-embedded
>> platforms. I wonder, though, if we really need to convert the drivers
>> to MFD ones, or if we could use the simpler MFD_SYSCON mechanism
>> which helps in exactly such cases for embedded platforms. But I am
>> really lacking details here and am afraid this is probably all the
>> input I can give currently.
>
> Zoltan stepped up, and uploaded a patch for review to the Kernel.org
> Bugzilla [2], also attached to this message.
>

Please don't send patches as attachments.

request_muxed_region() can fail, and literally every other driver
using it checks for that failure. Please do the same.

The sp5100_tco_dev_name change in the watchdog driver is unnecessary.
There are some unnecessary { } in the watchdog driver after the patch
is applied.

Please split the patch into two patches so they can be reviewed and
applied separately.

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
