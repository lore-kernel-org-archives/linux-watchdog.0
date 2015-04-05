Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57000 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbbDENFR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 5 Apr 2015 09:05:17 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YekEm-004OKK-DG
	for linux-watchdog@vger.kernel.org; Sun, 05 Apr 2015 13:05:16 +0000
Message-ID: <552132FD.8070202@roeck-us.net>
Date: Sun, 05 Apr 2015 06:05:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH V3 2/3] watchdog: imgpdc: Set timeout before starting
 watchdog
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org> <1428080722-29683-2-git-send-email-abrestic@chromium.org>
In-Reply-To: <1428080722-29683-2-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/03/2015 10:05 AM, Andrew Bresticker wrote:
> Set up the watchdog for the specified timeout before attempting to start it.
>
> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


