Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49914 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbbDMNxF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 13 Apr 2015 09:53:05 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YhenQ-00282r-1O
	for linux-watchdog@vger.kernel.org; Mon, 13 Apr 2015 13:53:04 +0000
Message-ID: <552BCA3E.5010305@roeck-us.net>
Date: Mon, 13 Apr 2015 06:53:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Stein <alexander.stein@systec-electronic.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: watchdog timeout in sub-seconds?
References: <3042537.C3OUI66IzY@ws-stein>
In-Reply-To: <3042537.C3OUI66IzY@ws-stein>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/13/2015 06:33 AM, Alexander Stein wrote:
> Hi,
>
> is there a specific reason that the timeout in the linux watchdog drivers is
> only provided in seconds resolution? What about timeouts in ms area/precision?
>

The question would probably be why not. On a loaded system, sub-second
watchdog timeouts are quite unreasonable.

In other words, you would have to provide a very good argument for
sub-second timeouts if you see the need for it. That some hardware
may require it is not really an argument here - this is all about
user space - kernel interface, not about limitations of specific
hardware.

Guenter

