Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EE30C37A;
	Mon, 23 Feb 2026 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866772; cv=none; b=ud02EjLJ2+roSDd12E/KFEFO0EI2uVFUzoqubg1pkSoaWUtQ7Add8MXtEt4SP2e/LHuEJEdbGu8ChXo079i15y7ijaTC37y7H6iqQJZwFCHQ18gYkUBPP2Udgkc+MpNuVlh0NgMDpX/kbJQTXfxkgAvgQsJBBsk+dOoXJ9AWUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866772; c=relaxed/simple;
	bh=d4wsjoRRB71H5+b3tRrdcJ6Gbai/g/ZhZLnfK9tMfo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZe2LVk0odhVr0H1iXxLaZLTlzHni4D69ZZDq+htwEVyMx5otKsHDheomQdkcpfzx5EwjZC9T9GxHepoIBgCP9X33HttLq/blgqiELSnRg0ZCyXQTol1fcFSofiNQc93NPdQr+lKc/x/bAGYwVJo/jnG6kxxyVuYyg84uL88KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6a/qdkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6a/qdkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB817C116C6;
	Mon, 23 Feb 2026 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866772;
	bh=d4wsjoRRB71H5+b3tRrdcJ6Gbai/g/ZhZLnfK9tMfo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6a/qdkdRJAmbnXK9ODTnjABZ/3UYjigJcENkioc9R6FSyuHNZgc3DFhU0nPs6nqJ
	 5epp8Uz/0QhLQREAEob8+laMvbFs+YKoz/KMFDU73UzpTf66oR84DPnnZjbVQ/Tl5I
	 tgFKwbfm4vIy2qNApqVSPVk4Rt4QJ8G2QydL6lI8d4/lq5WhXNt7hYE+y3SvMaPUO2
	 IF4AlamlcujY9qa6C1G2tY1Wh/9vnDgAmHgeO4YnlvGTisSLAEUbbQE//WFUJEEy5R
	 Vv+/I3Tb/qv+Y6HVntA64hnB5ee2c6GnPOidL5+SS/1j8Rhkmb860gibKHhYWjZA6E
	 zOLwpmmta7cwg==
Date: Mon, 23 Feb 2026 11:12:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/G3L
 support
Message-ID: <177186677039.4063791.8319336966121069475.robh@kernel.org>
References: <20260206112227.233229-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206112227.233229-1-biju.das.jz@bp.renesas.com>


On Fri, 06 Feb 2026 11:22:25 +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Document the support for the watchdog IP available on RZ/G3L SoC. The
> watchdog IP available on RZ/G3L SoC is identical to the one found on
> RZ/G2L SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../devicetree/bindings/watchdog/renesas,rzg2l-wdt.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

