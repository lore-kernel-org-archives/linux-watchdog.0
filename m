Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46212 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbFOVle (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 17:41:34 -0400
Message-ID: <557F4689.1050907@roeck-us.net>
Date: Mon, 15 Jun 2015 14:41:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	kernel@savoirfairelinux.com
Subject: Re: [RESEND PATCH 0/3] watchdog: MAX63xx cleanup and platform settings
References: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/15/2015 12:58 PM, Vivien Didelot wrote:
> The first version of this patchset from January, 29 [1] got no feedback
> from the maintainer. 1/4 [2] was applied to watchdog-next on May, 30
> though. A concern about constants removal was raised in the preliminary
> 2/4 cleanup patch, the explanation has been added to the related commit
> message.
>

Hi Vivien,

For my part, adding a comment about removal of constants does not alleviate
my concern about removing those constants. I just don't believe that removing
constants is a good idea, no matter what the arguments for doing so might be.

Thanks,
Guenter

