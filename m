Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53579 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbbDADvY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 23:51:24 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yd9gZ-003qVw-Hf
	for linux-watchdog@vger.kernel.org; Wed, 01 Apr 2015 03:51:23 +0000
Message-ID: <551B6B34.9060208@roeck-us.net>
Date: Tue, 31 Mar 2015 20:51:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Bresticker <abrestic@chromium.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH 4/4] watchdog: imgpdc: Add reboot support
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org> <1427827751-19705-4-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427827751-19705-4-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/31/2015 11:49 AM, Andrew Bresticker wrote:
> Register a restart handler that will restart the system by writing
> to the watchdog's SOFT_RESET register.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

