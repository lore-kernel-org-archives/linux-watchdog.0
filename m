Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:57415 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030957AbbD1Xbn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Apr 2015 19:31:43 -0400
Message-ID: <554017A7.9050506@imgtec.com>
Date: Tue, 28 Apr 2015 20:28:39 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"James Hogan" <james.hogan@imgtec.com>
Subject: Re: [PATCH V3 1/3] watchdog: imgpdc: Allow timeout to be set in device-tree
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org> <55400F0F.10204@imgtec.com>
In-Reply-To: <55400F0F.10204@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/28/2015 07:51 PM, Ezequiel Garcia wrote:
> 
> 
> On 04/03/2015 02:05 PM, Andrew Bresticker wrote:
>> Since the heartbeat is statically initialized to its default value,
>> watchdog_init_timeout() will never look in the device-tree for a
>> timeout-sec value.  Instead of statically initializing heartbeat,
>> fall back to the default timeout value if watchdog_init_timeout()
>> fails.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
> 
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> 

And for the three patches:

Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Any chance these get merged soon(ishly)?
-- 
Ezequiel
