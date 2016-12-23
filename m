Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:53639 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751493AbcLWIUb (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 03:20:31 -0500
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
Date: Fri, 23 Dec 2016 10:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/23/2016 03:55 AM, Guenter Roeck wrote:
> On 12/11/2016 03:21 AM, Vladimir Zapolskiy wrote:
>> On 12/11/2016 12:26 PM, Uwe Kleine-König wrote:
>>> Hello Vladimir,
>>>
>>> On Sun, Dec 11, 2016 at 12:01:08PM +0200, Vladimir Zapolskiy wrote:
>>>> On 12/11/2016 11:35 AM, Uwe Kleine-König wrote:
>>>>> On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
>>>>>> Power down counter enable/disable bit switch is located in WMCR
>>>>>> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
>>>>>> i.MX31 SoCs don't have this register. As a result of writing data to
>>>>>> the non-existing register on driver probe the SoC hangs up, to fix the
>>>>>> problem add more OF compatible strings and on this basis get
>>>>>> information about availability of the WMCR register.
>>>>>>
>>>>>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
>>>>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>>>>> ---
>>>>
> 
> 
> What is the ultimate conclusion of this exchange ?
> 
> Are we going to get another version of the patch, or did everyone agree that
> the patch is good as it is and does not require further changes ?
> 

I can not imagine a different fix.

--
With best wishes,
Vladimir

