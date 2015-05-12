Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:52746 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbELEMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 May 2015 00:12:36 -0400
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>,
	James Hogan <James.Hogan@imgtec.com>,
	James Hartley <James.Hartley@imgtec.com>
Subject: RE: [PATCH 2/2] watchdog: imgpdc: Add some documentation about the
 timeout
Date: Tue, 12 May 2015 04:12:29 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2FA9B034@hbmail01.hb.imgtec.org>
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1431366065-16281-3-git-send-email-ezequiel.garcia@imgtec.com>,<55516FDD.2040909@roeck-us.net>
In-Reply-To: <55516FDD.2040909@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On 05/11/2015 10:41 AM, Ezequiel Garcia wrote:
>> This watchdog hardware can be configured in terms of power-of-two
>> clock cycles. Therefore, the watchdog timeout configured by the user
>> will be rounded-up to the next possible hardware timeout.
>>
>> This commit adds a comment explaining this.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Many thanks for the review.

Regards,
Naidu.


