Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:53748 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935028AbcLWJ11 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 04:27:27 -0500
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
Date: Fri, 23 Dec 2016 11:27:24 +0200
MIME-Version: 1.0
In-Reply-To: <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/23/2016 10:32 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
>>> What is the ultimate conclusion of this exchange ?
>>>
>>> Are we going to get another version of the patch, or did everyone agree that
>>> the patch is good as it is and does not require further changes ?
>>>
>>
>> I can not imagine a different fix.
> 
> my preferred fix would be:
> 
>  - add an imx35 compatible to all newer dtsi
>  - update the driver to only write the wmcr on imx35 compatible devices
>    adding only imx35.
> 

It breaks old DTS vs. new kernel compatibility, I've already mentioned this.

--
With best wishes,
Vladimir
