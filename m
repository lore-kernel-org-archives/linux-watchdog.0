Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647542D7BF;
	Fri, 28 Aug 2026 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882924; cv=none; b=oGaoOsPVvYo3qkuKzTyt9xXWUYuKzvMKH6XQRMG0IKe8/l9M9jgWG8bs5PZJEVPRjIFR+9FBp9SxEsmASBUcf56LGA/o91vy7UOY2EfjhfT4mBmkHAnukaf4RNcRdvR1jgYZqym+BW6EHnvaBIUWr0JQ03ZT9vBKponGDqp/tKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882924; c=relaxed/simple;
	bh=yZVYPhaVNQP9vvyPtJZs6lK7f+T5rdAdvCp4UV7o4mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th4pQMXeE8nNZau6gWvsiKIskGLHBw0L+tOYy/x+6hgaC9umkoEnRxchgxeld7PtN4xKsojupeFpF73duxFTNR2kNMriG/tbazyvuZ4P2T7MJXcKC6bfuaFb0LkI7KlTp7EDpaerCjAgxevGf5YHXY559fc3MQNgKC6BwWR4LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdATG9Ma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdATG9Ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD0D1F000E9;
	Fri, 28 Aug 2026 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882923;
	bh=OIEvq6sgp0NvuCsndYEh7XZfc5tM1x73kGtjwkzUi+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FdATG9Ma027jZn6aRZQMyq/DwxzIfyJzHm5fIYbr7t8uoHWmoog7jja/nwYu81mym
	 wuKXrLln3nC2+G24K7AVxljWUpvK89xmNHHAijUoP7e/IB5+N0L9WtYJbUBr4BSVFz
	 S2c4SvhR63rBC1S0RJ3knGd7ztJTKoCN58/vs62AmMe/sxv6uDqnbutWXxUIXLv62U
	 uDzmWDpXhsWfCM/8ZKGFd2ULRh7yB7ddHs4zI4sqOaXC750QdTIM9w/BOXQmkrovNx
	 NGo8AK3RtcPxFPVhhTbYr7R85B+jeUAaf9QWaF7ZHGratpV2n5qST/vSeUXRkBxQWv
	 SIol3NpQVoBGg==
Date: Fri, 28 Aug 2026 02:08:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wanming Gao <wanming.gao@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wallace.yu@mediatek.com,
	Jarried.Lin@mediatek.com, vince-wl.liu@mediatek.com
Subject: Re: [PATCH v2] watchdog: mediatek: acknowledge pretimeout interrupt
Message-ID: <apDtp62h_4uZQ84H@google.com>
References: <20260827092616.2724197-1-wanming.gao@mediatek.com>
 <5e1793d5-6c78-4372-872a-069fcd99a07a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1793d5-6c78-4372-872a-069fcd99a07a@roeck-us.net>

On Thu, Aug 27, 2026 at 06:54:03AM -0700, Guenter Roeck wrote:
> On Thu, Aug 27, 2026 at 05:26:12PM +0800, Wanming Gao wrote:
> > The MediaTek watchdog pretimeout interrupt is level-triggered and does
> > not have a separate acknowledge register. The interrupt is cleared by
> > changing WDT_MODE_IRQ_LEVEL_EN and then restoring it to its original
> > state. Without this transition, the interrupt may remain asserted and
> > cause an interrupt storm.
> > 
> > After changing WDT_MODE_IRQ_LEVEL_EN, wait 70 us before restoring it.
> > This is longer than two 32 kHz watchdog clock cycles, allowing the
> > level change to propagate across the clock domain.
> > 
> > WDT_MODE is also updated by the watchdog start, stop, and pretimeout
> > operations. Protect its read-modify-write sequences and the complete
> > IRQ acknowledge sequence with the watchdog spinlock so that concurrent
> > updates cannot overwrite the temporary IRQ level state.
> > 
> > Signed-off-by: Wanming Gao <wanming.gao@mediatek.com>
> 
> Applied.

Might be a bit late, but tested on a MT8196 board:
Tested-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
