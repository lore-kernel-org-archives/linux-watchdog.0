Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5751474A7;
	Fri, 27 Dec 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285280; cv=none; b=SW5FyGtEDx0RZcV3AEQobQLgsTFECPF97H0WcDljM6BLHKz0ZRwcU4UjU9H2iF3n5h70unKRGKtS1fk8qJSTIOmqpmO4pYpaGcxukTAQlguqASQYLaaXmkx2HYcSvWqH7OsvDInfDBywkyFjOYacJ1al+WhbaQSEnjadnViH8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285280; c=relaxed/simple;
	bh=Nv1wEvIiSz34otyqL1cWSHe4aEEbKu9lOV86Lojbz1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b68t97iUk8H63NFyZtom706JHVFkUW3Mq6XwxrsBQRTw/MrnbXUlV48vLXuB+bqewon+MylE4nhhY7sBMXBg3lZM8JLeSAs5MdT2F7sSezLBIIIsZuVql/pPpQDCyrbiq25V6sNW2l8ZRf69GE3cT0p8/Rx045wghWJhy/N+kgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAG3nSqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAG3nSqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BC1C4CED0;
	Fri, 27 Dec 2024 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285279;
	bh=Nv1wEvIiSz34otyqL1cWSHe4aEEbKu9lOV86Lojbz1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAG3nSqUoLjqNqdnrKfDSSydnTG8EftoxKXyJKajCg4/3oyJAdps10ffKnK/izgWw
	 t6zr3PhNesqvalfAs6PjVupgiAkbuKi5d+nLbv7ooTSncslk8kT7QyjiImesdU4zv+
	 ST5Nz+RBgIMuz/KM4ZDZc/hq6dilHh5KjD+d4xP29qtlV45Fw94ezKeNQ8SmeD9Cuh
	 qKzidKcZZaBguXzmvMTf21Uccy9RgXXkcCw+PKKg47MStHy27F29vYl8pUMbh0R99B
	 dNbaZWbsAzdokpKs/xkyEyeNZ+6SDIDFAdJrdhp/Xr2oodw+IHhuVBIBUr50BDZYM4
	 zzn37hUpxxyeA==
Date: Fri, 27 Dec 2024 08:41:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Jamie Iles <jamie@jamieiles.com>, Guenter Roeck <linux@roeck-us.net>, 
	linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 07/17] dt-bindings: watchdog: Add rk3562 compatible
Message-ID: <4gotiybq2cjol43c4r25qyobl4bv7ccpxlcn5s4u3brb6g5ndf@663iergbbf5j>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-8-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-8-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:49:10PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-wdt for rk3562.

This we see from the diff. Say something not obvious. Where is the
driver change? Why devices are or are not compatible?

Best regards,
Krzysztof

