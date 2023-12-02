Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A9111A;
	Sat,  2 Dec 2023 11:25:59 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,246,1695654000"; 
   d="scan'208";a="185089885"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Dec 2023 04:25:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.28])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0D96A40765E0;
	Sun,  3 Dec 2023 04:25:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
Date: Sat,  2 Dec 2023 19:25:26 +0000
Message-Id: <20231202192536.266885-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document DA9063 watchdog device as it is similar to DA9062 watchdog.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 .../devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
index 2b71fdb9251c..ccec4d3e62f5 100644
--- a/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - dlg,da9062-watchdog
+              - dlg,da9063-watchdog
       - items:
           - enum:
               - dlg,da9061-watchdog
-- 
2.39.2

