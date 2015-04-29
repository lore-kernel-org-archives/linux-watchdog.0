Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38742 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbD2EK5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Apr 2015 00:10:57 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YnJKr-004MCJ-1v
	for linux-watchdog@vger.kernel.org; Wed, 29 Apr 2015 04:10:57 +0000
Message-ID: <554059C7.6070107@roeck-us.net>
Date: Tue, 28 Apr 2015 21:10:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH V3 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org> <55400F0F.10204@imgtec.com> <554017A7.9050506@imgtec.com>
In-Reply-To: <554017A7.9050506@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/28/2015 04:28 PM, Ezequiel Garcia wrote:
>
>
> On 04/28/2015 07:51 PM, Ezequiel Garcia wrote:
>>
>>
>> On 04/03/2015 02:05 PM, Andrew Bresticker wrote:
>>> Since the heartbeat is statically initialized to its default value,
>>> watchdog_init_timeout() will never look in the device-tree for a
>>> timeout-sec value.  Instead of statically initializing heartbeat,
>>> fall back to the default timeout value if watchdog_init_timeout()
>>> fails.
>>>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>> Cc: James Hogan <james.hogan@imgtec.com>
>>
>> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>
> And for the three patches:
>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>
> Any chance these get merged soon(ishly)?
>

I added the patches to my test branch. I'll send a pull request to
Wim in time for the next commit window, so hopefully the patches
should make it into 4.2.

Guenter

