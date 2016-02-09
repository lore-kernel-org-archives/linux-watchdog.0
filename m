Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32977 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbcBIO2R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Feb 2016 09:28:17 -0500
Subject: Re: [PATCH 1/3] watchdog: ts4800: add hardware dependency
To: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org
References: <20160209111549.7e9b4fbb@endymion>
 <20160209111748.4973e203@endymion>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56B9F77F.4040609@roeck-us.net>
Date: Tue, 9 Feb 2016 06:28:15 -0800
MIME-Version: 1.0
In-Reply-To: <20160209111748.4973e203@endymion>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/09/2016 02:17 AM, Jean Delvare wrote:
> The Technologic Systems TS-4800 is an i.MX515 board, so its drivers
> are useless unless building a SOC_IMX51 kernel, except for build
> testing purposes.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

