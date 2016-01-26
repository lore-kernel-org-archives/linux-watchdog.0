Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34885 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965985AbcAZObQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 09:31:16 -0500
Date: Tue, 26 Jan 2016 09:31:06 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
Message-ID: <20160126143106.GA5539@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/25/2016 5:11 PM, Guenter Roeck wrote:
>> +		dev_warn(dev, "Invalid timeout (%u seconds), using default (%u seconds)\n",
>> +			timeout, WATCHDOG_TIMEOUT);
>
> Multi-line alignment is off by one character.

I used tabs to align the lines to 8-character boundaries. Should I add
an additional space to align the "timeout" argument with the "dev"
argument?

William Breathitt Gray
