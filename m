Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579A36A340;
	Tue, 28 Jul 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239231; cv=none; b=uhaZXFzHmNDvRvw1bBIVudAHIbh3VvvHQn1d034QRfuHt+48ZjaoSMKQiI8VmPLbg8328vMBwzmP9hngdrmcrAI9gNv8CDrH6M2oOh3THePfRI20vnU6PDRk+A2TRJ9GvgFbmZtKZ7ejWWDN57QRMZQDg1FtHGo6cP9cU2fzvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239231; c=relaxed/simple;
	bh=rK+2Kdy1HzPnYODLZSpSfWRswH4Sy6H+7CzGfzv0Gqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKPzptWuOg9ELisMz3XcV0b1PhZf9DMhMNgjIKPRNOAltr0WfZ+yeKlNe8EjXhhXu1IWasQlEOWZzDs9rb6QKqPO27vM2nVTUNcsFLYn7+7GAsoldklM9XZxXMHJ35EdCM5LwM0N52L2zxxBraXegiMOzAQVpBdp4bj2JSWy4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdT9UaTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdT9UaTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967631F000E9;
	Tue, 28 Jul 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785239230;
	bh=kz328Jkxf+8X1DF5jn9LNfWNLIBNgP8sOglDIke6D+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gdT9UaTr8H9qzj59Gqk9lm2OTK9NYQ7TkumIo/tEBM+oUeD3WB+7GCYmeEtKp8V28
	 Hq0O15kGjthYdOtdzGYvdNps1hvHT9bt0vSpvH5Xr9BYGVaoA+vJOj3dOfe3YB0TL0
	 nGktxq4Rul/JXef/5Pb8jBxEiIXDptRm3ozLkjFcM5liyTelQ8hsdFvhB5pFc/t2Te
	 1rKMBq78YDkm+Yzb4HfAaBrHnhiOy9crELqopiiAK22Dd+2RzHQz34qL1BWRD5vjUn
	 f91lNwaRsVYIwBQamJNMSMretqVs+YOv7rtZHicL3bqlaeatWg3WgOTmuzu8gULsxH
	 jzDZm+b4D6QAg==
Date: Tue, 28 Jul 2026 13:47:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: watchdog: Add MA35D1 Watchdog binding
Message-ID: <20260728-poetic-outstanding-salmon-6fabb3@quoll>
References: <20260724091427.1689980-1-zychennvt@gmail.com>
 <20260724091427.1689980-2-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724091427.1689980-2-zychennvt@gmail.com>

On Fri, Jul 24, 2026 at 05:14:25PM +0800, Zi-Yu Chen wrote:
> Add device tree binding documentation for the watchdog timer (WDT)
> controller found on Nuvoton MA35D1 SoC.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

