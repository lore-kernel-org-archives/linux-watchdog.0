Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57722 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbKWQCj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 11:02:39 -0500
Subject: Re: [PATCH 1/2] watchdog: gpio-wdt: Rename notifier to
 reboot_notifier
To: Alexander Stein <alexander.stein@systec-electronic.com>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
 <5652A51C.2030509@roeck-us.net> <1928403.ZSnPjExYYh@ws-stein>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5653389A.60904@roeck-us.net>
Date: Mon, 23 Nov 2015 08:02:34 -0800
MIME-Version: 1.0
In-Reply-To: <1928403.ZSnPjExYYh@ws-stein>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 05:29 AM, Alexander Stein wrote:
> On Sunday 22 November 2015 21:33:16, Guenter Roeck wrote:
>> On 11/09/2015 01:55 AM, Alexander Stein wrote:
>>> This is a preparation before adding a panic notifier.
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>>
>> Fyi, we are going to have an infrastructure change which will make this patch unnecessary.
>>
>> See http://patchwork.roeck-us.net/patch/451/ and http://patchwork.roeck-us.net/patch/452/
>> for details.
>
> Both links are not working for me. Give me a 404 error.
>

Hmm - interesting. Try

https://www.mail-archive.com/linux-watchdog@vger.kernel.org/msg02136.html
https://www.mail-archive.com/linux-watchdog@vger.kernel.org/msg02139.html

Guenter

