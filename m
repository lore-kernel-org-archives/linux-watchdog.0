Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BBF191F94;
	Thu, 27 Aug 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823421; cv=none; b=P1LZ4YMua7PNqYRCsfcfsSQXHJnhjSBTtt4MLZzfRKqvJOFKskutslEs+2/vrsMm0vFjY6KpLI9tKzvCaGQQpdwnx8iLGLyknYdhwR9WgW6vVpskGJpnkmd5O82mBsdN/yLsv8Dd8AFrd7+YC32Ybi8Ws+zIgMaSzCagx1mIacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823421; c=relaxed/simple;
	bh=+bVq8o2eSObX+wEpXGAxQICUmhmHFxrbqqxyQ9He4bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEbVP0Vwo48nIbLW9KyK2pIlygwxvArhj7TFZOWuxaoxquKGwLs4oZB18kDPnqKBJJmqXmVOEu04mIYxk09sHPn5ji6YB8ecOM5mMEw1b2iRlEqesPgPmxAxqQjVALv38Yk3wuXews2VlBT/yjz9KAE152CuzxrrXcVWg9mO+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFl7Tl3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFl7Tl3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4901F000E9;
	Thu, 27 Aug 2026 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787823418;
	bh=ftRbte7T4ElO9W9tRcYR3ZcEJ5DoXrSeyHGUb8+QPCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RFl7Tl3/yLatV9LE6qXyJRB4RbWbl98BsaqdGi3+7RSoUCCVi2A1aq7LiEqVYeaT/
	 +HDT/YgyH0nFRNIbMGzsbzwDfmE1q31c7ddzzAJ6VzSFcmrp/LQYERA4aJQcyFooJX
	 oFSMNAqOrTKlfYlONjuY0bRIYOCzhWdBbVL6AiDaS3B0KVB2ivK/wLcSzf+FUw5jjh
	 iz9e8AODCkrNu4/cfyhICSw1MvtDRVsfHurmuC8X3jS9WyvVMCPNw82iKw3EhL7pZh
	 VIlJvjOKtHnBLFU/cfFvDkq/khg4YObj3B6iJRdixGUZ+GBPnr4TPcWntoNwaUHRj2
	 UkdC0gXpyK9rA==
Date: Thu, 27 Aug 2026 11:36:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/7] watchdog: mediatek: Add wdt/toprgu resets for
 mt6589
Message-ID: <20260827-clever-cherry-zebu-6a98f1@quoll>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-3-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819101853.44681-3-l.scorcia@gmail.com>

On Wed, Aug 19, 2026 at 12:16:23PM +0200, Luca Leonardo Scorcia wrote:
> According to Android sources, mt6589 has 12 reset bits in the
> WDT_SWSYSRST register. Populate toprgu_sw_rst_num to allow toprgu resets
> in device trees of the many compatible devices.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  drivers/watchdog/mtk_wdt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16..f8208fb0f723 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <dt-bindings/reset/mt2712-resets.h>
> +#include <dt-bindings/reset/mediatek,mt6589-wdt.h>

I do not see how you use the bindings here, so my previous comments
stay. You just ignored it and never replied. In such case:

NAK

Best regards,
Krzysztof

