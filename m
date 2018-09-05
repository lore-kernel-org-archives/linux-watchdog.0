Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
Date: Wed, 5 Sep 2018 06:34:49 +0200
From: Marek Behun <marek.behun@nic.cz>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org
Subject: Re: [PATCH v2 2/4] dt-bindings: watchdog: Document armada-37xx-wdt
 binding
Message-ID: <20180905063449.60dc9f0a@nic.cz>
In-Reply-To: <2e522394-e8ea-badf-5db2-b01a6c391462@roeck-us.net>
References: <20180904095627.25552-1-marek.behun@nic.cz>
	<20180904095627.25552-2-marek.behun@nic.cz>
	<20180904120007.34c6b4a7@dellmb.labs.office.nic.cz>
	<2e522394-e8ea-badf-5db2-b01a6c391462@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

:-( Should I have added Cc for devicetree maintainers only for this one
patch (2/4), or the whole series?
Marek

On Tue, 4 Sep 2018 17:55:54 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 09/04/2018 03:00 AM, Marek Beh=C3=BAn wrote:
> > Hi Guenter,
> > I have sent this patch to devicetree mailing list on Friday but no
> > one was able to review it yet. I wanted to wait till they review it
> > before sending these patches so that you could apply them if there
> > are no more problems, but after three days I sent them anyway so at
> > least you could watch the rest of the changes.
> >  =20
>=20
> You should have copied the dt maintainers on _this_ patch. Not doing
> so means that we will likely miss the DT maintainer's Ack, which in
> turn will mean that we won't apply the entire series. And if we _do_
> notice the DT maintainer Ack for some reason, we'll have to manually
> add it to this patch (which is the one we are tracking) because
> patchwork won't see it.
>=20
> In other words, you have created a lot of additional work for
> maintainers and risk for the series for no good reason by submitting
> the same patch multiple times to different people. Always keep
> patches together in a series, and never submit the same patch
> multiple times to different mailing lists/people.
>=20
> Guenter
