Return-path: <thomas.petazzoni@free-electrons.com>
Date: Fri, 3 Mar 2017 09:03:25 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Wenyou.Yang@microchip.com, linux-kernel@vger.kernel.org, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Wim Van Sebroeck <wim@iguana.be>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] watchodg: sama5d4: simplify probe
Message-ID: <20170303090325.41b9ce64@free-electrons.com>
In-Reply-To: <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
	<20170302173114.28508-4-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On Thu,  2 Mar 2017 18:31:13 +0100, Alexandre Belloni wrote:

> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);

Any reason to use irq_of_parse_and_map() over the more conventional
platform_get_irq() ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
