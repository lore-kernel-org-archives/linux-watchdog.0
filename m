Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46061 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbcBFQfM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Feb 2016 11:35:12 -0500
Subject: Re: [RFC 2/4] watchdog: ni9x3x_wdt: Add counter sysfs attribute
To: Josh Cartwright <joshc@ni.com>,
	Kyle Roeschley <kyle.roeschley@ni.com>
References: <1454635683-13668-1-git-send-email-kyle.roeschley@ni.com>
 <1454635683-13668-2-git-send-email-kyle.roeschley@ni.com>
 <20160205195336.GB9579@jcartwri.amer.corp.natinst.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B620BA.8000009@roeck-us.net>
Date: Sat, 6 Feb 2016 08:35:06 -0800
MIME-Version: 1.0
In-Reply-To: <20160205195336.GB9579@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/05/2016 11:53 AM, Josh Cartwright wrote:
> On Thu, Feb 04, 2016 at 07:28:01PM -0600, Kyle Roeschley wrote:
>> The NI 9x3x watchdog timer has 30.72 µs resolution, so expose this
>> by allowing the user to set the timeout counter directly via a sysfs
>> attribute.
>
> But _why_?  That isn't clear to me.  Why do we want a user to directly
> muck with the counter value?  (As opposed to working in units of time?).
>

In addition to that, this also messes up the watchdog core's notion of
wdd->timeout, meaning the watchdog subsystem would no longer report
the actually configured timeout value to user space.

Guenter

