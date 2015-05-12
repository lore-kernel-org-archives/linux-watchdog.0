Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57830 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbELDN1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 11 May 2015 23:13:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1Ys0dK-0026Uy-VJ
	for linux-watchdog@vger.kernel.org; Tue, 12 May 2015 03:13:27 +0000
Message-ID: <55516FBF.1020407@roeck-us.net>
Date: Mon, 11 May 2015 20:13:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>,
	James Hogan <james.hogan@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: Re: [PATCH 1/2] watchdog: imgpdc: Fix max timeout
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com> <1431366065-16281-2-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431366065-16281-2-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/11/2015 10:41 AM, Ezequiel Garcia wrote:
> Maximum timeout is currently set in clock cycles, but the watchdog
> core expects it to be in seconds. Fix it.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

