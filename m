Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585617;
	b=zSnd3RXhAthXxBJkO/yu4K/TOP8SY0sQDeglyOjLcpkzjId6WDZeIUhp2IqAoQ0KafkK
	 YahS5MZa6mXF/I6sEqKEUqJjxFy0qRWqTL5g7x1oaT9JlxNaiSQ5xWTsLbz7D4ISXLHud
	 YtrtzggGN12t0Sjr+ubQDnaiaE2cISKTqLJtrfQeyymmNkNzugAtAZwG00deNGZnSUaFt
	 4d344vfN4eM7UUqwYFN68qDuHBrusO+KiQJTHH8qLmfZi2ifpnqKJtQWiFyJw0wuUQRtE
	 yZoHOjV5HHtx+2kKWIpSzy5kZ/JySHf4duzZ53SFh/LqXmH/Llm7jHTlS2rTPdmM+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=NZvMNl2rNVFYgW+nN3Oiao9vOrIiaQuXf3slC6NOLHc=;
	b=A8qmBDqOr++oEz3ktUcR9wjE6TB/c9uR8nDqWItoHlWk91P0JhnjWASs4IhmzV/Wd0u+
	 WaNNaV6loCYjx7q2bEpXKZmZa2dkCO7udfnF9OkJtgdwHvgjItlUnEPYiwMq2XxeJEC/Y
	 hkqz/3uev1mIM1Liqo8cAJ2MpM8Ddyd3KIFiw/nCQiYy+XY352bzX4hGkHA3CN8dXxq1x
	 DIZeAUinAbjjZ8LcoF7vAbz/9LB2qbnpD9xaZeo4jQPZ+noAeS0xa5RokS9m/n2wArFvJ
	 cC9KqaqONPdT7VQGrhqblrfqe+Fpki4jF+Codgi01fb/sWVclbsUgo2oN79ydomCxvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZSS3Xjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B9606A31E;
	Wed, 25 Nov 2026 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZSS3Xjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A44C1F000C0;
	Wed, 25 Nov 2026 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795585617;
	bh=NZvMNl2rNVFYgW+nN3Oiao9vOrIiaQuXf3slC6NOLHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZSS3XjbHJB70TEIMIH5E5DolRbuhiUDofhGwQDDGnX93idGLqQZZGdbFWY9kiojd
	 3RD6bhErUoAk01krQmpoCoLon20uuKYR1REPuvhYrtTx32WyEmfp/ouz/XYlf/k/3z
	 qcHQNRu4k3CWr7jazMBR02BZ88SwHGSZ+R7OHW6LNPLo1rBYIsGUj41qHu21kfcQ6M
	 Su71AKROPAUHYdDVxOrKLdccHe1untKHTQrmR1lqr2y7KY2t0XoeBK2vGy4xVe5aTg
	 vwX+muJOS2QQbseq7smY6qzMmD2MHvRRTLchrHy/QoCa/gcagnqX95jtwPikAkEMTg
	 QzTYZZotfiRKg==
Date: Wed, 25 Nov 2026 05:46:52 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] watchdog: max63xx_wdt: Add support for specifying
 WDI logic via GPIO
Message-ID: <awZ2TJRVus2R-ePn@google.com>
References: <20261124050118.87944-1-pepe.schlehofer@gmail.com>
 <20261124050118.87944-3-pepe.schlehofer@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124050118.87944-3-pepe.schlehofer@gmail.com>

On Tue, Nov 24, 2026 at 06:01:17AM +0100, Josef Schlehofer wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> On some boards the WDI (watchdog input) pin of the chip is connected to
> a GPIO, and only the SET pins are mapped to the register.
> 
> Take the GPIO from the optional wdi-gpios property. When it is present,
> ping the watchdog through it instead of the register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> [pepe.schlehofer@gmail.com: use wdi-gpios, request the GPIO as an output
>  with devm_gpiod_get_optional(), ping without the lock, include
>  linux/delay.h, update the header comment]
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

The patch looks good to me,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
