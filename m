Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24551 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919AbcANQ1s (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jan 2016 11:27:48 -0500
Subject: Re: [PATCH] watchdog: add sun4v_wdt device support
To: Guenter Roeck <linux@roeck-us.net>
References: <1452640232-1165-1-git-send-email-wim.coekaerts@oracle.com>
 <20160113011231.GB22429@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	sparclinux@vger.kernel.org
From: Wim Coekaerts <wim.coekaerts@oracle.com>
Message-ID: <5697CC54.1090808@oracle.com>
Date: Thu, 14 Jan 2016 08:27:00 -0800
MIME-Version: 1.0
In-Reply-To: <20160113011231.GB22429@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 1/12/16 5:12 PM, Guenter Roeck wrote:
> On Tue, Jan 12, 2016 at 03:10:32PM -0800, wim.coekaerts@oracle.com wrote:
>> From: Wim Coekaerts <wim.coekaerts@oracle.com>
>>
>> This adds a simple watchdog timer for the SPARC sunv4 architecture.
>> Export the sun4v_mach_set_watchdog() hv call, and add the target.
>> The driver was based on the same model used by the Xen watchdog driver.
>>
>> This was tested on T2, T4, T5 and T7.
>>
>> Signed-off-by: Wim Coekaerts <wim.coekaerts@oracle.com>
> Please use the watchdog subsystem for new drivers.
Ah wasn't clear that that was a requirement.. OK let me try and use the 
new subsystem instead.

