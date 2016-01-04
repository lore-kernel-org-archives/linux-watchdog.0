Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34401 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcADDxv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Jan 2016 22:53:51 -0500
Subject: Re: [PATCH 0/3] watchdog: Drop pointer to watchdog device from struct
 watchdog_device
To: linux-watchdog@vger.kernel.org
References: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5689ECCC.9070501@roeck-us.net>
Date: Sun, 3 Jan 2016 19:53:48 -0800
MIME-Version: 1.0
In-Reply-To: <1451862718-31073-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/03/2016 03:11 PM, Guenter Roeck wrote:
> The lifetime of the watchdog device pointer is different from the lifetime
> of its character device. Remove it entirely to avoid race conditions, and
> to make sure that drivers don't start to use it again.
>

I should have mentioned: The series applies on top of watchdog-next.

Guenter

