Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44464 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbFUMet (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Jun 2015 08:34:49 -0400
Message-ID: <5586AF65.1080403@roeck-us.net>
Date: Sun, 21 Jun 2015 05:34:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	"Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
Subject: Re: [PATCH v2] watchdog: hpwdt: Add support for WDIOC_SETOPTIONS
References: <20150621093233.2f97739c@endymion.delvare>
In-Reply-To: <20150621093233.2f97739c@endymion.delvare>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/21/2015 12:32 AM, Jean Delvare wrote:
> WDIOC_SETOPTIONS makes it possible to disable and re-enable the
> watchdog timer while the hpwdt driver is loaded.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
