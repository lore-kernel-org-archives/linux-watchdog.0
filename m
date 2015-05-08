Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43574 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbEHBrt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 21:47:49 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YqXOG-002yfC-Kh
	for linux-watchdog@vger.kernel.org; Fri, 08 May 2015 01:47:48 +0000
Message-ID: <554C15C2.60802@roeck-us.net>
Date: Thu, 07 May 2015 18:47:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>, wim@iguana.be
CC: jszhang@marvell.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: dw_wdt: keepalive the watchdog at write
 time
References: <1431036564-4189-1-git-send-email-dianders@chromium.org> <1431036564-4189-2-git-send-email-dianders@chromium.org>
In-Reply-To: <1431036564-4189-2-git-send-email-dianders@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2015 03:09 PM, Doug Anderson wrote:
> If you've got code that does this in a tight loop
>    1. Open watchdog
>    2. Send 'expect close'
>    3. Close watchdog
> ...you'll eventually trigger a watchdog reset.  You can reproduce this
> by using daisydog (1) and running:
>    while true; do daisydog -c > /dev/null; done
>
> The problem is that each time you write to the watchdog for 'expect
> close' it moves the timer .5 seconds out.  The timer thus never fires
> and never pats the watchdog for you.
>
> 1: http://git.chromium.org/gitweb/?p=chromiumos/third_party/daisydog.git
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


