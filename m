Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:45841 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752333AbbD0FuI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Apr 2015 01:50:08 -0400
Message-ID: <553DCE0A.6010906@offcode.fi>
Date: Mon, 27 Apr 2015 08:50:02 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 7/8] watchdog: omap_wdt: Fix memory leak on probe fail
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi> <553D0503.7050207@roeck-us.net>
In-Reply-To: <553D0503.7050207@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 26.04.2015 18:32, Guenter Roeck wrote:
> On 04/22/2015 04:11 AM, Timo Kokkonen wrote:
>> Structures allocated on the beginning of the probe function must be
>> freed in case of failure.
>
> Really ? The functions are allocated with devm_kzalloc.
> It might be useful to introduce an error on purpose, have the code
> jump to your new label, and observe what happens.

Interesting. I wasn't aware of devm_kzalloc. I will have to remove this 
patch from the series and rework the another omap patch to apply without 
this. Thanks!

-Timo
