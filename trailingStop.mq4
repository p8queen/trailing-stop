//+------------------------------------------------------------------+
//|                                                 trailingStop.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict

int orders, a;
double profitMinimo=0.2;
double orProfit = 0;
double trailinStop = 50*Point;
double newStopLoss;
bool res;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(1);
   Comment("Point: ",Point,", trailingStop: ", trailinStop); 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   //EventKillTimer();
      
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //check profit TotalOrders
   orders = OrdersTotal()-1;
   for(a=orders;a>=0;a--){
      if(OrderSelect(a,SELECT_BY_POS)){
         orProfit = OrderProfit()+OrderSwap()+OrderCommission();
         Comment("Check orderProfit >= profitMinimo ",orProfit," >= ", profitMinimo, 
               "\n Point: ",Point,", trailingStop: ", trailinStop, ", OrderProfit: ",OrderProfit(),
               ", OrderTicket: ",OrderTicket());
         if(orProfit >= profitMinimo){
            
            if(OrderType()==OP_BUY)
               newStopLoss = Bid-trailinStop;
              else
               newStopLoss = Ask+trailinStop;
         
         res = OrderModify(OrderTicket(),OrderOpenPrice(),newStopLoss,OrderTakeProfit(),0);
            if(!res)
               Print("Error in OrderModify. Error code=",GetLastError());
            else
               Print("Order modified successfully.");
         }
            
         }
   
   
      }
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
