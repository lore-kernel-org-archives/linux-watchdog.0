Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:54936 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbbJARag (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Oct 2015 13:30:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2015 19:20:32 +0200
From: <harald@ccbib.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: <rtc-linux@googlegroups.com>, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <20150505094031.GH4276@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org> <20150417093023.GF29796@piout.net> <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net> <20150419153743.GA4353@piout.net> <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net> <20150505094031.GH4276@piout.net>
Message-ID: <c75c3f0a5a1a136bac7c882178b01815@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

sorry for the very long delay.=20

I tried your suggestion to switch the watchdog driver to regmap several
times but couldn't come up with something that wasn't either very ugly
or completely pointless - i.e. no better then passing a pointer to the
register block. See below.

On Tue, 5 May 2015 11:40:31 +0200, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>=20
> On 20/04/2015 at 09:11:02 +0200, harald@ccbib.org wrote :
>> Hi Alexandre,
>>=20
>> On Sun, 19 Apr 2015 17:37:43 +0200, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
>> >> >  - use syscon instead of passing callbacks to the watchdog driver
>> >>=20
>> >> I will put looking into this onto my todo list, but I'm not familia=
r
>> >> with syscon yet and it is not obvious to me how to port the rtc
driver
>> >> to syscon without breaking devicetree backwards compatibility. So
I'd
>> >> like to defer this for later unless somebody gives me some guidance=
.
>> >=20
>> > As the rtc driver is the one instantiating the watchdog driver, ther=
e
>> > is
>> > no reason why the DT ABI would be broken. You simply have to create
>> > the syscon in the RTC driver and then pass it to the watchdog driver=
,
>> > the same way it is done with the callbacks.
>>=20
>> Ok, this is less invasive than what I have been thinking. This makes
>> sense.=20
>=20
> I realized I confused syscon with regmap. So indeed, switching to sysco=
n
> will require a not nice change to the DT. But what I really meant was
> creating a regmap from the rtc driver and pass it to the watchdog
> driver.

Since the rtc and watchdog drivers need different bits of the same contro=
l
register, we would need to use regmap_fields to pass them around.
Unfortunately this means we can't use the _SET and _CLR registers, which
means we need to use regmap everywhere to get proper locking. A lot of
overhead for no benefit.

After reading lots of messages around the genesis and usage of
regmap_mmio,
it seems to me the intended usecases are to fix some endianness issues
and to have a register cache available during suspend - both of which
don't
apply in this case.

If you want to get rid of the callbacks we should just pass the pointer
to the register block to the child device, I think. Which way is
preferable
is probably only a matter of taste so I won't override the driver authors
decision unless there is some clear statement that this is the preferred
style in the rtc subsystem.

I will send the other patch (unify register access macros) you asked abou=
t
shortly.

Harald
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
