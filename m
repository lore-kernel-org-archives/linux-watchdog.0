Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A504E1C6F;
	Mon, 21 Sep 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010151; cv=none; b=Qz+TXcC720g28XXFRmj/LtZhIUKXmswh6x8P73FJeQBqMub4mlk3GNhwiR+sF3aGLZbClcAw1ZiTsgRMmoeyh9Sf6SiPYw6IbHxFKX1o3Z23jbFZPT2CtoeRjmCcZJMJsjI5s90EeSPPqSWMIFO8zQdNyqH2JZZ+6ZTZ49eDoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010151; c=relaxed/simple;
	bh=zruz5pSX0IFVF60i85hd8Lvq+Ul9hFBO34ep3iK9dAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVIK/glb/AG/ZMJabq4pszLva40YHQMrj+BIuF0+SJc7vdgQ41b2sdlRtZtq2T/gSOx+3W5Rv9Mew3gUyX3iJqcM5uSGRxkNynPaogQbwvN1pmX35FN0vP9dezsxgK7+NfgqSGhWxoAsGnm0NOHkLv4i+Tu04IrrhnVGUlkZAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTtnJOeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTtnJOeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0867A1F000FF;
	Mon, 21 Sep 2026 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790010150;
	bh=LSoPUiNFV7sDPwgktuLCo3QMbLsdxew16T11Y37maic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTtnJOeSE02PG9l7tC/sMv1gvjCtvpABc2hwUlkbhhQYFe00oCpVtnLyBY0cS399k
	 aQSiGrKH9hU3dHEfyy6eJ9TnFnkXuKZARrEINuMCS1BIgx3kqm013+Ba76X6+lX1bj
	 BI7dLBEogEihhGtxTB83Kty9dbBhLuf4cvsRX/utiX969ly43k8+XpSPbh73Pwxyni
	 sWNFJxIzJt7YdWRmMpu+RemxXBTEvG/L7RF/2jSzJMR5b9dVH9dRCPTH/RO1NfpoUk
	 3h7wNQDwYiGSeGx+XcoVtnfzOo2U1lOisSDTXGymvzidPI2TeuaqdVA0tSPqFZRcR6
	 u+9iohDWmwW4A==
Date: Mon, 21 Sep 2026 12:02:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: linux-arm-kernel@lists.infradead.org, Neal Gompa <neal@gompa.dev>,
	devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Guenter Roeck <linux@roeck-us.net>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
	Radu Rendec <radu@rendec.net>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 6/7] dt-bindings: arm: apple: Add A18 Pro based devices
Message-ID: <179001014799.898882.8311603733010649075.robh@kernel.org>
References: <20260911-apple-a18-pro-initial-devicetrees-v2-0-08d06cf011d4@cyberchaos.dev>
 <20260911-apple-a18-pro-initial-devicetrees-v2-6-08d06cf011d4@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-apple-a18-pro-initial-devicetrees-v2-6-08d06cf011d4@cyberchaos.dev>


On Fri, 11 Sep 2026 18:58:43 +0200, Yureka Lilian wrote:
> The MacBook Neo is the first MacBook to use an A-Series Apple Silicon
> SoC. The MacBook Neo is overall similar to the M4 series devices.
> 
> The iPhone 16 Pro is based on the same SoC, but Apple does not allow
> users running a custom OS on this device.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

