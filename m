Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35033 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbcDLNjp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2016 09:39:45 -0400
Message-ID: <570CFA90.4060100@gmail.com>
Date: Tue, 12 Apr 2016 19:09:28 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
CC: linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: dw_wdt: dont build for avr32
References: <1460440303-20640-1-git-send-email-sudipm.mukherjee@gmail.com> <570CF2CB.2050200@roeck-us.net>
In-Reply-To: <570CF2CB.2050200@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 12 April 2016 06:36 PM, Guenter Roeck wrote:
> On 04/11/2016 10:51 PM, Sudip Mukherjee wrote:
>> The build of avr32 allmodconfig fails with the error:
>> ERROR: "__avr32_udiv64" [drivers/watchdog/kempld_wdt.ko] undefined!
>>
> This means there is a direct 64 bit divide operation in the driver,
> which we should identify and fix.

yes, there is.

in function: kempld_wdt_set_stage_timeout()
remainder = do_div(stage_timeout64, prescaler);

Any idea how to fix it?

regards
sudip
