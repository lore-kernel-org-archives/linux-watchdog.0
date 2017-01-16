Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:47227 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbdAPVsn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jan 2017 16:48:43 -0500
Subject: Re: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
 <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
 <20170116204337.j67oeknraas7ryib@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org,
        Magnus Lilja <lilja.magnus@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <0586b2cd-6cbb-2e8a-9cd6-d7220708931d@mleia.com>
Date: Mon, 16 Jan 2017 23:48:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170116204337.j67oeknraas7ryib@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/16/2017 10:43 PM, Uwe Kleine-König wrote:
> On Mon, Jan 16, 2017 at 04:35:26PM -0200, Fabio Estevam wrote:
>> On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-König
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> Only i.MX35 and newer feature a WMCR register that should be written to. Older
>>> SoCs hang when this address is written.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Only a minor nit: Subject could: ARM: dts: imx: teach...
> 
> Ack. To reference the commit id of the first patch in the third I can
> prepare a branch to pull. There I'd fix the Subject. Shawn, is this OK?
> 

This is too early for changes, which are not reviewed by Linux watchdog masters.

As I emphasized multiple times in our discussions your series is organized
improperly, it has interdependencies between DTS and driver, it lacks
atomicity feature of a proper fix, in the middle it breaks backward compatibility
with old DTB, all that makes it impossible to send an atomic fix for linux-stable,
some of the changes are captured from mine ones without preserving the authorship
or even a reported-by credit.

--
With best wishes,
Vladimir
