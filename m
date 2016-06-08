Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:56691 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbcFHM6m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 08:58:42 -0400
Subject: Re: [PATCH v3 1/6] watchdog: add set_pretimeout interface
To: Wolfram Sang <wsa@the-dreams.de>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608063458.GA1521@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <5758167C.9080301@mentor.com>
Date: Wed, 8 Jun 2016 15:58:36 +0300
MIME-Version: 1.0
In-Reply-To: <20160608063458.GA1521@katana>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 08.06.2016 09:34, Wolfram Sang wrote:
> On Tue, Jun 07, 2016 at 08:38:42PM +0300, Vladimir Zapolskiy wrote:
>> From: Robin Gong <b38343@freescale.com>
>>
>> Add set_pretimeout since our watchdog driver has those interfaces and
>> obviously, the new common watchdog framework didn't implement this
>> interface.
>>
>> Signed-off-by: Robin Gong <b38343@freescale.com>
>> [vzapolskiy: rebased, added an inline comment to describe new interface]
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> 
> Why didn't you just take my patch and worked on it? This would have
> added the documentation Guenter explicitly requested when reviewing
> Robin's patch. And it would have get rid of the bug you have in the
> *_invalid function. I also don't think the split-up into three patches
> is necessary here, but that might just be me.
> 

I agree, your version is obviously more advanced, I will take it for v4.

Best wishes,
Vladimir

