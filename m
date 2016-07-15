Return-path: <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Fri, 15 Jul 2016 20:21:01 -0300
Message-ID: <CAAEAJfAEKvLCk2gjj6MR00t-Yg_-XEG1qb0ij6jse=FV3ez5bw@mail.gmail.com>
Subject: Can't query Intel's iTCO watchdog reboot reason
To: dvhart@infradead.org, Guenter Roeck <linux@roeck-us.net>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi everyone,

A large portion of my intel-based products are suffering from
a nasty hardware freeze [1], and so I'm currently working this around
enabling the iTCO watchdog -- which in any case, it's a good idea
to have enabled.

So, it would be interesting to find out on each boot if the machine was
rebooted due to a watchdog timeout, but so far I'm not having any luck.

As per Intel's appnote [2] the BIOS should update the WDDT ACPI table,
so I added something like this to the iTCO driver:

       status =3D acpi_get_table(ACPI_SIG_WDDT, 1,
                               (struct acpi_table_header **) &buf);
       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
               pr_err(FW_BUG "failed to get WDDT ACPI table\n");
               return;
       }

But it doesn't find the table. Strangely, reading TCO1_STS
and TCO2_STS always gives 0x0.

Tests were done on a Lynx Point:

[    7.131502] iTCO_wdt: Found a Lynx Point TCO device (Version=3D2,
TCOBASE=3D0x1860)

Any ideas? Is it possible to get this information or should I just gave up?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D109051
[2] http://download.intel.com/design/chipsets/applnots/29227301.pdf

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
