Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43374 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbcBVOtN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 09:49:13 -0500
Subject: Re: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org
References: <20160222121132.665b1f77@endymion>
Cc: Justin Chen <justinpopo6@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56CB1FE5.8080206@roeck-us.net>
Date: Mon, 22 Feb 2016 06:49:09 -0800
MIME-Version: 1.0
In-Reply-To: <20160222121132.665b1f77@endymion>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/22/2016 03:11 AM, Jean Delvare wrote:
> The BCM7038 is a MIPS chip so do not present its driver on other
> architectures, unless build-testing.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Justin Chen <justinpopo6@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

