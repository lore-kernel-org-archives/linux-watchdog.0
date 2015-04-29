Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:46370 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422762AbbD2MRi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Apr 2015 08:17:38 -0400
Message-ID: <5540CB2B.5060100@imgtec.com>
Date: Wed, 29 Apr 2015 09:14:35 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
	Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"James Hogan" <james.hogan@imgtec.com>
Subject: Re: [PATCH V3 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org> <55400F0F.10204@imgtec.com> <554017A7.9050506@imgtec.com> <554059C7.6070107@roeck-us.net>
In-Reply-To: <554059C7.6070107@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/29/2015 01:10 AM, Guenter Roeck wrote:
> On 04/28/2015 04:28 PM, Ezequiel Garcia wrote:
>>
>>
>> On 04/28/2015 07:51 PM, Ezequiel Garcia wrote:
>>>
>>>
>>> On 04/03/2015 02:05 PM, Andrew Bresticker wrote:
>>>> Since the heartbeat is statically initialized to its default value,
>>>> watchdog_init_timeout() will never look in the device-tree for a
>>>> timeout-sec value.  Instead of statically initializing heartbeat,
>>>> fall back to the default timeout value if watchdog_init_timeout()
>>>> fails.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>>> Cc: James Hogan <james.hogan@imgtec.com>
>>>
>>> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>>
>>
>> And for the three patches:
>>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>> Any chance these get merged soon(ishly)?
>>
> 
> I added the patches to my test branch. I'll send a pull request to
> Wim in time for the next commit window, so hopefully the patches
> should make it into 4.2.
> 

OK, cool. Thanks a lot.

-- 
Ezequiel
