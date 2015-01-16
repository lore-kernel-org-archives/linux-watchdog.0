Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60644 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbAPOcc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Jan 2015 09:32:32 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YC7wu-002AAN-Sj
	for linux-watchdog@vger.kernel.org; Fri, 16 Jan 2015 14:32:32 +0000
Message-ID: <54B920FC.8090905@roeck-us.net>
Date: Fri, 16 Jan 2015 06:32:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Athira Lekshmi <andnlnbn18@gmail.com>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] watchdog: wdt_pci: Fixed missing blank line warning
References: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
In-Reply-To: <1421335926-3321-1-git-send-email-andnlnbn18@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/15/2015 07:31 AM, Athira Lekshmi wrote:
> Add a new line after declarations to remove the checkpatch warning:
> 'Missing blank line after declarations'
>
> Signed-off-by: Athira Lekshmi <andnlnbn18@gmail.com>
> ---
> Changes in v2:
>    -  Make the commit message more clearer.
>

The patches are all good, though I would suggest something like
"Add missing blank lines" as subject, and I would suggest to merge
the 8 watchdog patches into one.

Thanks,
Guenter

