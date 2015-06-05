Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36574 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbbFENOe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Jun 2015 09:14:34 -0400
Message-ID: <5571A0B5.5030205@roeck-us.net>
Date: Fri, 05 Jun 2015 06:14:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Rinne <markus.rinne@vincit.fi>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: Fix ioctl() results
References: <20150605124144.GA26755@markusri_laptop.vincit.intranet>
In-Reply-To: <20150605124144.GA26755@markusri_laptop.vincit.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/05/2015 05:41 AM, Markus Rinne wrote:
> WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT returned the initial timeout and
> not the one that was last set.  Fix this by updating struct
> watchdog_device member 'timeout'.  This is how it's supposed to be done
> according to Documentation/watchdog/watchdog-kernel-api.txt.
>
> This is the test case I used:
>
> #include <fcntl.h>
> #include <linux/watchdog.h>
> #include <sys/stat.h>
> #include <sys/types.h>
>
> #include <assert.h>
> #include <stdlib.h>
>
> static const int TIMEOUT = 127;
>
> int main(void)
> {
> 	int fd = open("/dev/watchdog", O_WRONLY);
> 	if (fd == -1)
> 		return EXIT_FAILURE;
>
> 	int timeout = TIMEOUT;
> 	ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
> 	assert(timeout == TIMEOUT);
>
> 	close(fd);
>
> 	return EXIT_SUCCESS;
> }
>
> Signed-off-by: Markus Rinne <markus.rinne@vincit.fi>
> ---

Good catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

