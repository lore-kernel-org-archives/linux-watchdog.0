Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:7948 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbELEOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 May 2015 00:14:08 -0400
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>,
	James Hogan <James.Hogan@imgtec.com>,
	James Hartley <James.Hartley@imgtec.com>
Subject: RE: [PATCH 1/2] watchdog: imgpdc: Fix max timeout
Date: Tue, 12 May 2015 04:14:03 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2FA9B03F@hbmail01.hb.imgtec.org>
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1431366065-16281-2-git-send-email-ezequiel.garcia@imgtec.com>,<55516FBF.1020407@roeck-us.net>
In-Reply-To: <55516FBF.1020407@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On 05/11/2015 10:41 AM, Ezequiel Garcia wrote:
>> Maximum timeout is currently set in clock cycles, but the watchdog
>> core expects it to be in seconds. Fix it.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Many thanks for the review.

Regards,
Naidu.
