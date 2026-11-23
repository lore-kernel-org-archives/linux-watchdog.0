Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429512;
	b=WNXmtiOUdf/cLFh9kVIr6eO5oV73Ub99kJQ4I7boVE0gCdw98GWbgFIYCC2bDN2qnmlp
	 zeDKe7ohpkEj20UaC8iILzaMIN+xlVYPVdPXUCMZkz50TzEoXAmLJLA1ynSr2u01oLoFw
	 RO7fP1ZPcK330wlWbqnhw7GTvHVjUCuLfdJsbpnqtFluti+5+nmzT/BEHfCT3SnabxUpr
	 GDWcSagogEdGzE3LVWahGa926MSt5/Zc3DKJkK7Vqf9TPuvaM5WUDI5Rd0rBTfA4LVuwY
	 BqCjahhVzfCLR+V/ccwRxbL8cGDfEX0yXqOh20mCi9nfy6Vy4ZabUw7cW7O7aklPSfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HShQYBoN+lq3SMXJHKw1mjT/FJkIWiPoGDoMTbC13e0=;
	b=pNcfYjBki2eVrTCgE9YStxWAHXXGCwlGu2qaFQW9GCgp/TEUui6oT4WISDW8ryzku4Z1
	 tFHpbghOtOK2jcgfGJdHBSUpjVtwJURy51hOy9vOre3VH6lAbypi7W1Wi1xlsdGQpyoV4
	 dqilCuwyqGaRXOFg6D3655dEvwzpMH5jBjmhS+HHGyNoWO6cY9KPZWpGUP/pszUWv6A6V
	 KDojTePx2WkkTKeY4X6DA5HhD6X4XmnS8Q2RHEnzmSEAudp0Fhs8keO0vSiO76dh6/ETN
	 wcfgiKA9XihRX+DeAI342RH19s3zU0btwZDUydcY8M/jJC8kEIeBqhqSmmYascJ4EtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8dNt4If;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2A606A31A;
	Mon, 23 Nov 2026 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8dNt4If
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40A1F000D0;
	Mon, 23 Nov 2026 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429512;
	bh=HShQYBoN+lq3SMXJHKw1mjT/FJkIWiPoGDoMTbC13e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R8dNt4IfHLpO34t0/G73vv8nZuc7o5oZExq856QBhhDq3uavjr/4APO6ct8MJ7Kly
	 nKodU5Ti0rGDqwjoVQJD/tooW62DQqsNJCLqOejvPndTBLHxMZOx3Vfsyr/1PTIvnm
	 aqT31DbSFoQDm1Oo95ba2SIbhjktZWRzbrS9v7hhM/5R8+YbSSihJjyiGyIzngQud7
	 9iDRcWdXdxJslCeWkNDQ359mUrECU9cLYL6mowr8+zL/h3Pr4zXg8GIM3Z1O8kDSwj
	 A2JXks8BJ1f6RPuukTLrrmfsFUUs+PK2i2qhaFnpbZLzM34DImGGpgxQ/nyxULwGrx
	 woM7xA3e1ucLw==
Date: Mon, 23 Nov 2026 11:25:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: linux-watchdog@vger.kernel.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: arm,sp805: reference the
 PrimeCell binding
Message-ID: <20261123-wealthy-imperial-woodlouse-d7c6f1@quoll>
References: <20261114184257.535546-1-mmyangfl@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114184257.535546-1-mmyangfl@gmail.com>

On Sun, Nov 15, 2026 at 02:42:33AM +0800, David Yang wrote:
> Unlike the other PrimeCell bindings, the binding ends in
> unevaluatedProperties: false without referencing
> /schemas/arm/primecell.yaml#, so arm,primecell-periphid is not an
> evaluated property on an arm,sp805 node. Two nodes in the tree carry
> that property regardless -- watchdog@a2c000 in hisi-x5hd2.dtsi and
> watchdog@8000 in mps2.dtsi.
> 
> `make CHECK_DTBS=y`:
> 
>   watchdog@a2c000 (arm,sp805): Unevaluated properties are not allowed
>   ('arm,primecell-periphid' was unexpected)
> 
> Add the reference so the property becomes evaluable; both nodes then
> validate.
> 
> Fixes: 73d3e43f9813 ("dt-bindings: watchdog: sp-805: Convert to Json-schema")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

