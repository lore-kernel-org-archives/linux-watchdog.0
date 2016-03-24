Return-path: <mmcclint@codeaurora.org>
Subject: Re: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to BITE time
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160323224226.GD18567@codeaurora.org>
Date: Thu, 24 Mar 2016 10:46:42 -0500
Cc: andy.gross@linaro.org,
 linux-arm-msm@vger.kernel.org,
 qca-upstream.external@qca.qualcomm.com,
 Wim Van Sebroeck <wim@iguana.be>,
 Guenter Roeck <linux@roeck-us.net>,
 "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19DAEEE1-1019-49FB-A921-4311F592A7EC@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org> <20160323224226.GD18567@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Mar 23, 2016, at 5:42 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>=20
> On 03/23, Matthew McClintock wrote:
>> For certain parts and some versions of TZ, TZ will reset the chip
>> when a BARK is triggered even though it was not configured here. So
>> by default let's configure this BARK time as well.
>>=20
>=20
> Why isn't TZ configuring the bark time to what it wants? I'm lost
> why we have to do this for them.

So it was done like this to ensure we had a valid upgrade. The =
bootloader is using the watchdog to ensure the system is bootable and if =
not it will revert back to the working images.

Bottom line is, for some versions of TZ out there, if we enable watchdog =
coming out of boot the bark time is already configured by the boot =
loader and TZ is configured to intercept this interrupt and do some =
register saving (for crashdump) and we end up getting a watchdog reset =
during boot.

It=E2=80=99s even a little more complex, because in order for the TZ to =
save the registers you need to pad the BITE time a bit higher than the =
BARK time, but I was leaving that for another day.

-M=
